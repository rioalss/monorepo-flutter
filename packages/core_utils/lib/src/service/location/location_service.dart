// ignore_for_file: document_ignores

import 'package:core_utils/src/constants/app_durations.dart';
import 'package:core_utils/src/helpers/logger.dart';
import 'package:core_utils/src/service/models/app_location_model.dart';
import 'package:geolocator/geolocator.dart';

/// Facade over [Geolocator] for permission checks, settings, and position reads.
///
/// Returns normalized [AppLocationModel] instances. Recoverable states such as
/// disabled location services or denied permissions yield `null` instead of
/// throwing.
///
/// Example:
/// ```dart
/// final location = await LocationService.getCurrentPosition();
/// if (location == null) return;
/// print('${location.latitude}, ${location.longitude}');
/// ```
abstract final class LocationService {
  LocationService._();

  /// Whether device location services (GPS) are enabled.
  static Future<bool> isServiceEnabled() => Geolocator.isLocationServiceEnabled();

  /// Current location permission status.
  static Future<LocationPermission> checkPermission() =>
      Geolocator.checkPermission();

  /// Requests location permission when currently denied.
  static Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();

  /// Opens the app settings page (e.g. when permission is denied forever).
  static Future<bool> openAppSettings() => Geolocator.openAppSettings();

  /// Opens the system location settings page.
  static Future<bool> openLocationSettings() =>
      Geolocator.openLocationSettings();

  /// Reads the current device position.
  ///
  /// Checks service availability and permission first. Returns `null` when
  /// location is unavailable or permission is denied.
  ///
  /// [accuracy] defaults to [LocationAccuracy.high].
  /// [timeLimit] defaults to [AppDurations.apiTimeout].
  static Future<AppLocationModel?> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration timeLimit = AppDurations.apiTimeout,
  }) async {
    try {
      if (!await isServiceEnabled()) {
        AppLogger.w('LocationService.getCurrentPosition: services disabled');
        return null;
      }

      final permission = await _ensurePermission();
      if (permission == null) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: accuracy,
          timeLimit: timeLimit,
        ),
      );

      return AppLocationModel.fromPosition(position);
    } on Object catch (error, stackTrace) {
      AppLogger.e(
        'LocationService.getCurrentPosition failed',
        error,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Returns the last known cached position, if any.
  ///
  /// Faster than [getCurrentPosition] but may be stale. Does not request
  /// permission — returns `null` when no cached fix exists.
  static Future<AppLocationModel?> getLastKnownPosition() async {
    try {
      final position = await Geolocator.getLastKnownPosition();
      if (position == null) {
        return null;
      }
      return AppLocationModel.fromPosition(position);
    } on Object catch (error, stackTrace) {
      AppLogger.e(
        'LocationService.getLastKnownPosition failed',
        error,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Distance between two coordinates in meters.
  static double distanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) =>
      Geolocator.distanceBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      );

  /// Distance between two coordinates in kilometers.
  static double distanceBetweenKm({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) =>
      distanceBetween(
        startLatitude: startLatitude,
        startLongitude: startLongitude,
        endLatitude: endLatitude,
        endLongitude: endLongitude,
      ) /
      1000;

  /// Ensures usable permission; returns `null` when access cannot be granted.
  static Future<LocationPermission?> _ensurePermission() async {
    var permission = await checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      AppLogger.w(
        'LocationService: permission denied (${permission.name})',
      );
      return null;
    }

    return permission;
  }
}
