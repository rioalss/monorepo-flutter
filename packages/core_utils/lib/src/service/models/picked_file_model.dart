// ignore_for_file: document_ignores, comment_references

import 'dart:typed_data';

import 'package:core_utils/core_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart' show XFile;

/// Unified representation of a user-picked file across picker services.
///
/// Produced by [FilePickerService] and [ImagePickerService]. At least one of
/// [path] or [bytes] should be available for downstream upload/compression.
class PickedFileModel {
  const PickedFileModel({
    required this.name,
    this.path,
    this.size,
    this.mimeType,
    this.bytes,
  });

  /// Maps a [file_picker] result. [bytes] is populated only when `withData`
  /// was enabled on the pick call.
  factory PickedFileModel.fromPlatformFile(PlatformFile file) =>
      PickedFileModel(
        name: file.name,
        path: file.path,
        size: file.size,
        bytes: file.bytes,
      );

  /// Original file name including extension.
  final String name;

  /// Local filesystem path. May be `null` on web or when only [bytes] exist.
  final String? path;

  /// File size in bytes when known.
  final int? size;

  /// MIME type when reported by the picker (more common from [fromXFile]).
  final String? mimeType;

  /// In-memory payload. Loaded eagerly by [fromXFile] when [path] is absent,
  /// or when [FilePickerService] picks with `withData: true`.
  final Uint8List? bytes;

  /// Maps an [image_picker] [XFile] to this model.
  ///
  /// When a non-empty [path] exists (typical on native), [bytes] stays `null`
  /// to avoid loading the file into memory. On web, where [path] is often empty,
  /// [bytes] are read eagerly via [XFile.readAsBytes].
  static Future<PickedFileModel> fromXFile(XFile file) async {
    final path = file.path;
    final hasPath = path.isNotEmpty;

    return PickedFileModel(
      name: file.name,
      path: hasPath ? path : null,
      size: await file.length(),
      mimeType: file.mimeType,
      bytes: hasPath ? null : await file.readAsBytes(),
    );
  }
}
