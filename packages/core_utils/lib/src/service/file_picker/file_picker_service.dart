// ignore_for_file: document_ignores, comment_references

import 'package:core_utils/src/helpers/logger.dart';
import 'package:core_utils/src/service/models/picked_file_model.dart';
import 'package:file_picker/file_picker.dart';

/// Facade over [FilePicker] that returns normalized [PickedFileModel] instances.
///
/// Wraps platform file picking with consistent error logging. User cancellation
/// returns `null` (single) or an empty list (multiple); platform errors rethrow.
///
/// Example:
/// ```dart
/// final doc = await FilePickerService.pickFile(
///   type: FileType.custom,
///   allowedExtensions: ['pdf', 'doc'],
/// );
/// if (doc == null) return; // user cancelled
/// ```
abstract final class FilePickerService {
  FilePickerService._();

  /// Opens the system file picker and returns the first selected file.
  ///
  /// [type] and [allowedExtensions] filter the picker (extensions apply when
  /// [type] is [FileType.custom]). Set [withData] to `true` to populate
  /// [PickedFileModel.bytes] — required on web where [path] may be unavailable.
  ///
  /// Returns `null` when the user cancels or selects nothing.
  static Future<PickedFileModel?> pickFile({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool withData = false,
  }) async {
    final files = await _pickPlatformFiles(
      type: type,
      allowedExtensions: allowedExtensions,
      withData: withData,
      debugLabel: 'pickFile',
    );

    if (files == null) {
      return null;
    }

    return PickedFileModel.fromPlatformFile(files.first);
  }

  /// Opens the system file picker and returns all selected files.
  ///
  /// Same filtering and [withData] semantics as [pickFile]. Returns an empty
  /// list when the user cancels or selects nothing.
  static Future<List<PickedFileModel>> pickMultipleFiles({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool withData = false,
  }) async {
    final files = await _pickPlatformFiles(
      type: type,
      allowedExtensions: allowedExtensions,
      withData: withData,
      allowMultiple: true,
      debugLabel: 'pickMultipleFiles',
    );

    if (files == null) {
      return [];
    }

    return files.map(PickedFileModel.fromPlatformFile).toList();
  }

  /// Shared [FilePicker.pickFiles] call with logging. Returns `null` on cancel.
  static Future<List<PlatformFile>?> _pickPlatformFiles({
    required FileType type,
    required List<String>? allowedExtensions,
    required bool withData,
    required String debugLabel,
    bool allowMultiple = false,
  }) async {
    try {
      final result = await FilePicker.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        withData: withData,
        allowMultiple: allowMultiple,
      );

      if (result == null || result.files.isEmpty) {
        return null;
      }

      return result.files;
    } on Object catch (error, stackTrace) {
      AppLogger.e('FilePickerService.$debugLabel failed', error, stackTrace);
      rethrow;
    }
  }
}
