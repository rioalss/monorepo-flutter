// ignore_for_file: document_ignores, comment_references

import 'dart:io';

import 'package:core_utils/src/helpers/logger.dart';
import 'package:core_utils/src/service/models/picked_file_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Starting JPEG quality for the first compression pass.
const _initialQuality = 95;

/// Quality decrement per iteration in phase 1.
const _qualityStep = 5;

/// Lowest quality tried before switching to dimension reduction.
const _minQuality = 10;

/// Initial max-width bound passed to [FlutterImageCompress] (package naming).
const _initialMinWidth = 1920;

/// Initial max-height bound passed to [FlutterImageCompress] (package naming).
const _initialMinHeight = 1080;

/// Multiplier applied to dimensions in phase 2 when quality alone is insufficient.
const _dimensionScaleFactor = 0.9;

/// Maximum dimension-reduction passes in phase 2.
const _maxDimensionIterations = 8;

/// Compresses picked images toward a target file-size ceiling.
///
/// Uses a two-phase strategy: lower JPEG quality first, then reduce dimensions.
/// Output is always re-encoded as JPEG. Safe to call from picker services.
abstract final class ImageCompressHelper {
  ImageCompressHelper._();

  /// Compresses [source] until its size is at or below the target, or returns
  /// the smallest achievable result.
  ///
  /// [minSizeMb] is the target **maximum** size in megabytes (default 2 MB).
  /// Returns [source] unchanged when already within the limit or when
  /// compression produces no usable output.
  ///
  /// On failure, logs and rethrows. When the target cannot be reached, logs a
  /// warning and returns the best-effort compressed bytes.
  static Future<PickedFileModel> compressToTarget({
    required PickedFileModel source,
    double minSizeMb = 2,
  }) async {
    try {
      final targetBytes = (minSizeMb * 1024 * 1024).round();
      final sourceSize = source.size;

      if (sourceSize != null && sourceSize <= targetBytes) {
        return source;
      }

      final compressed = await _compressIteratively(
        source: source,
        targetBytes: targetBytes,
      );

      if (compressed == null) {
        return source;
      }

      return _buildCompressedModel(source: source, bytes: compressed);
    } on Object catch (error, stackTrace) {
      AppLogger.e(
        'ImageCompressHelper.compressToTarget failed',
        error,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Runs quality-then-dimension passes until [targetBytes] is met or exhausted.
  ///
  /// Tracks the smallest result across all attempts. Returns `null` only when
  /// every pass fails to produce bytes.
  static Future<Uint8List?> _compressIteratively({
    required PickedFileModel source,
    required int targetBytes,
  }) async {
    Uint8List? bestResult;
    var bestSize = source.size ?? (1 << 30);

    var quality = _initialQuality;
    var minWidth = _initialMinWidth;
    var minHeight = _initialMinHeight;

    // Phase 1: reduce JPEG quality while keeping initial dimensions.
    while (quality >= _minQuality) {
      final result = await _compressOnce(
        source: source,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
      );
      if (result == null) {
        break;
      }

      if (result.length < bestSize) {
        bestSize = result.length;
        bestResult = result;
      }

      if (result.length <= targetBytes) {
        return result;
      }

      quality -= _qualityStep;
    }

    // Phase 2: hold quality at minimum and shrink dimensions progressively.
    quality = _minQuality;
    minWidth = _initialMinWidth;
    minHeight = _initialMinHeight;

    for (var i = 0; i < _maxDimensionIterations; i++) {
      minWidth = (minWidth * _dimensionScaleFactor).round();
      minHeight = (minHeight * _dimensionScaleFactor).round();

      final result = await _compressOnce(
        source: source,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
      );
      if (result == null) {
        break;
      }

      if (result.length < bestSize) {
        bestSize = result.length;
        bestResult = result;
      }

      if (result.length <= targetBytes) {
        return result;
      }
    }

    if (bestResult != null && bestSize > targetBytes) {
      AppLogger.w(
        'ImageCompressHelper: unable to reach target '
        '${targetBytes ~/ (1024 * 1024)}MB, '
        'best size: ${(bestSize / (1024 * 1024)).toStringAsFixed(2)}MB',
      );
    }

    return bestResult;
  }

  /// Performs a single compression pass via file path or in-memory bytes.
  ///
  /// Prefers [FlutterImageCompress.compressWithFile] on native when [source.path]
  /// is available. Falls back to [compressWithList] on web or when only bytes
  /// exist. Returns `null` when no readable input is available.
  static Future<Uint8List?> _compressOnce({
    required PickedFileModel source,
    required int quality,
    required int minWidth,
    required int minHeight,
  }) async {
    final path = source.path;
    if (!kIsWeb && path != null && path.isNotEmpty) {
      return FlutterImageCompress.compressWithFile(
        path,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
      );
    }

    final inputBytes = source.bytes ?? await _readBytesFromPath(path);
    if (inputBytes == null) {
      return null;
    }

    return FlutterImageCompress.compressWithList(
      inputBytes,
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
    );
  }

  /// Reads file bytes on native platforms. Returns `null` on web or invalid paths.
  static Future<Uint8List?> _readBytesFromPath(String? path) async {
    if (kIsWeb || path == null || path.isEmpty) {
      return null;
    }

    return File(path).readAsBytes();
  }

  /// Builds a JPEG [PickedFileModel] and writes a temp file on native platforms.
  ///
  /// On web, [path] falls back to [source.path] because the filesystem is
  /// unavailable; [bytes] always carries the compressed payload.
  static Future<PickedFileModel> _buildCompressedModel({
    required PickedFileModel source,
    required Uint8List bytes,
  }) async {
    final jpgName = _jpegFileName(source.name);
    String? path;

    if (!kIsWeb) {
      path =
          '${Directory.systemTemp.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await File(path).writeAsBytes(bytes);
    }

    return PickedFileModel(
      name: jpgName,
      path: path ?? source.path,
      size: bytes.length,
      mimeType: 'image/jpeg',
      bytes: bytes,
    );
  }

  /// Replaces or appends a `.jpg` extension for the compressed output name.
  ///
  /// Names without an extension (or with a leading dot) get `.jpg` appended.
  static String _jpegFileName(String originalName) {
    final dotIndex = originalName.lastIndexOf('.');
    if (dotIndex <= 0) {
      return '$originalName.jpg';
    }

    return '${originalName.substring(0, dotIndex)}.jpg';
  }
}
