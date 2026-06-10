/// Environment-driven API configuration helpers.
///
/// Reads values from `.env` via `flutter_dotenv` and exposes factory methods
/// for building `DioClientConfig` instances per base URL.
library;

import 'package:core_network/src/client/dio_client_config.dart';
import 'package:core_network/src/config/endpoints.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Reads environment variables from `.env` and exposes helpers to build
/// [DioClientConfig] instances.
///
/// Load your `.env` file before calling any method:
/// ```dart
/// await dotenv.load(fileName: '.env');
/// ```
class ApiConfig {
  const ApiConfig._();

  /// Primary REST API base URL from `API_BASE_URL`.
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? '';

  /// Base URL for paginated list endpoints from `API_LIST_BASE_URL`.
  static String get listBaseUrl => dotenv.env['API_LIST_BASE_URL'] ?? '';

  /// Centrifuge server URL from `CENTRIFUGE_URL`.
  static String get centrifugeUrl => dotenv.env['CENTRIFUGE_URL'] ?? '';

  /// WebSocket server URL from `WEBSOCKET_URL`.
  static String get websocketUrl => dotenv.env['WEBSOCKET_URL'] ?? '';

  /// Google Maps API key from `GOOGLE_MAP_API_KEY`.
  static String get googleMapApiKey => dotenv.env['GOOGLE_MAP_API_KEY'] ?? '';

  /// Current deployment environment from `ENVIRONMENT`, defaulting to `development`.
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  /// Whether the app runs in a production environment.
  static bool get isProduction => environment.toLowerCase() == 'production';

  /// API version segment appended when versioning is enabled.
  static const String apiVersion = 'v1';

  /// Whether to append [apiVersion] to [baseUrl].
  ///
  /// When `false` (default), [fullBaseUrl] is [baseUrl] only — for DummyJSON.
  /// Set `API_USE_VERSION=true` in `.env` for versioned APIs (`/v1`).
  static bool get useApiVersion =>
      dotenv.env['API_USE_VERSION']?.toLowerCase() == 'true';

  /// Resolved base URL, optionally including the version segment.
  static String get fullBaseUrl =>
      useApiVersion ? '$baseUrl/$apiVersion' : baseUrl;

  /// Creates a [DioClientConfig] pre-filled with environment-based defaults.
  ///
  /// [publicPaths] defaults to [Endpoints.publicPaths] when omitted.
  static DioClientConfig defaultConfig({
    List<String>? publicPaths,
  }) =>
      DioClientConfig(
        baseUrl: fullBaseUrl,
        enableLogging: !isProduction,
        publicPaths: publicPaths ?? Endpoints.publicPaths,
      );

  /// Config for list endpoints (e.g. paginated users via [listBaseUrl]).
  ///
  /// [publicPaths] defaults to [Endpoints.publicPaths] when omitted.
  static DioClientConfig listConfig({
    List<String>? publicPaths,
  }) =>
      DioClientConfig(
        baseUrl: listBaseUrl,
        enableLogging: !isProduction,
        publicPaths: publicPaths ?? Endpoints.publicPaths,
      );
}
