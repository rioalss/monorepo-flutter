import 'package:core_utils/src/helpers/image_compress_helper.dart';
import 'package:core_utils/src/helpers/logger.dart';
import 'package:core_utils/src/service/models/picked_file_model.dart';
import 'package:image_picker/image_picker.dart';

/// Facade for gallery/camera image picking with automatic compression.
///
/// Returns normalized [PickedFileModel] instances. User cancellation yields
/// `null` (single) or an empty list (multiple). All picks are compressed
/// toward minSizeMb via [ImageCompressHelper].
///
/// Example:
/// ```dart
/// final file = await ImagePickerService.pickFromGallery(minSizeMb: 2);
/// if (file == null) return; // user cancelled
/// ```
abstract final class ImagePickerService {
  ImagePickerService._();

  static final ImagePicker _picker = ImagePicker();

  /// Picks one image from the gallery and compresses it.
  ///
  /// [minSizeMb] is the target maximum output size in megabytes (default 2).
  /// Returns `null` when the user cancels.
  static Future<PickedFileModel?> pickFromGallery({
    double minSizeMb = 2,
  }) =>
      _pickSingle(
        source: ImageSource.gallery,
        minSizeMb: minSizeMb,
        debugLabel: 'pickFromGallery',
      );

  /// Captures one image from the camera and compresses it.
  ///
  /// [minSizeMb] is the target maximum output size in megabytes (default 2).
  /// Returns `null` when the user cancels.
  static Future<PickedFileModel?> pickFromCamera({
    double minSizeMb = 2,
  }) =>
      _pickSingle(
        source: ImageSource.camera,
        minSizeMb: minSizeMb,
        debugLabel: 'pickFromCamera',
      );

  /// Picks multiple images from the gallery and compresses each in parallel.
  ///
  /// [limit] caps selection count on supported platforms. Returns an empty list
  /// when the user cancels or selects nothing.
  static Future<List<PickedFileModel>> pickMultipleFromGallery({
    double minSizeMb = 2,
    int? limit,
  }) async {
    try {
      final files = await _picker.pickMultiImage(limit: limit);

      if (files.isEmpty) {
        return [];
      }

      final picked = await Future.wait(files.map(PickedFileModel.fromXFile));

      return Future.wait(
        picked.map(
          (file) => _compressPicked(file, minSizeMb: minSizeMb),
        ),
      );
    } on Object catch (error, stackTrace) {
      AppLogger.e(
        'ImagePickerService.pickMultipleFromGallery failed',
        error,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Shared single-image flow: pick → normalize → compress.
  ///
  /// Returns `null` when the user dismisses the picker without selecting.
  static Future<PickedFileModel?> _pickSingle({
    required ImageSource source,
    required String debugLabel,
    double minSizeMb = 2,
  }) async {
    try {
      final file = await _picker.pickImage(source: source);

      if (file == null) {
        return null;
      }

      final picked = await PickedFileModel.fromXFile(file);

      return _compressPicked(picked, minSizeMb: minSizeMb);
    } on Object catch (error, stackTrace) {
      AppLogger.e('ImagePickerService.$debugLabel failed', error, stackTrace);
      rethrow;
    }
  }

  /// Delegates size reduction to [ImageCompressHelper.compressToTarget].
  static Future<PickedFileModel> _compressPicked(
    PickedFileModel picked, {
    required double minSizeMb,
  }) =>
      ImageCompressHelper.compressToTarget(
        source: picked,
        minSizeMb: minSizeMb,
      );
}
