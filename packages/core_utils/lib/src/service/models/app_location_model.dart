// ignore_for_file: document_ignores, comment_references

import 'package:geolocator/geolocator.dart';

/// Normalized device location produced by [LocationService].
///
/// Keeps [geolocator.Position] out of app/feature code.
class AppLocationModel {
  const AppLocationModel({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.heading,
    this.speed,
    this.timestamp,
  });

  /// Maps a [geolocator] [Position] to this model.
  factory AppLocationModel.fromPosition(Position position) => AppLocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        heading: position.heading,
        speed: position.speed,
        timestamp: position.timestamp,
      );

  /// Latitude in degrees (-90 to 90).
  final double latitude;

  /// Longitude in degrees (-180 to 180).
  final double longitude;

  /// Estimated horizontal accuracy in meters, when available.
  final double? accuracy;

  /// Altitude in meters above the WGS 84 reference ellipsoid, when available.
  final double? altitude;

  /// Heading in degrees (0–359.99), when available.
  final double? heading;

  /// Speed in meters per second, when available.
  final double? speed;

  /// Timestamp of the position fix, when reported by the platform.
  final DateTime? timestamp;
}
