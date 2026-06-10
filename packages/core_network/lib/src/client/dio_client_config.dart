/// Immutable configuration for a single Dio client instance.
///
/// Create one config per base URL; load `.env` before relying on `ApiConfig`
/// defaults for `baseUrl` and logging flags.
library;

import 'package:core_network/src/config/api_config.dart';
import 'package:core_network/src/config/endpoints.dart';

/// Immutable per-instance configuration for `DioClient`.
///
/// Create one config per base URL your app talks to:
/// ```dart
/// final mainApi = DioClientConfig(); // uses ApiConfig.fullBaseUrl
/// final cdnApi  = DioClientConfig(
///   baseUrl: 'https://cdn.example.com',
///   enableAuth: false,
///   enableLogging: false,
/// );
/// ```
///
/// Load `.env` via `dotenv.load()` before constructing configs that rely on
/// [ApiConfig].
class DioClientConfig {
  /// Creates a config with optional overrides for timeouts, headers, and auth.
  ///
  /// [baseUrl] defaults to [ApiConfig.fullBaseUrl].
  /// [enableLogging] defaults to `!ApiConfig.isProduction`.
  /// [publicPaths] defaults to [Endpoints.publicPaths].
  DioClientConfig({
    String? baseUrl,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.headers = const {},
    this.maxRetryAttempts = 1,
    bool? enableLogging,
    this.enableAuth = true,
    this.publicPaths = Endpoints.publicPaths,
  })  : baseUrl = baseUrl ?? ApiConfig.fullBaseUrl,
        enableLogging = enableLogging ?? !ApiConfig.isProduction;

  /// REST API base URL for this client instance.
  final String baseUrl;

  /// Maximum time to establish a TCP connection.
  final Duration connectTimeout;

  /// Maximum time to wait for a complete response body.
  final Duration receiveTimeout;

  /// Maximum time to send the request body.
  final Duration sendTimeout;

  /// Custom headers merged with `DioDefaultHeaders.json`.
  final Map<String, String> headers;

  /// Number of automatic retries for transient failures; `0` disables retry.
  final int maxRetryAttempts;

  /// Whether request/response logging is enabled for this client.
  final bool enableLogging;

  /// When `false`, the auth interceptor is not added to this client.
  final bool enableAuth;

  /// Paths that skip the auth header (matched via `String.contains`).
  final List<String> publicPaths;
}
