/// Default HTTP headers applied to every Dio client instance.
///
/// Merged with per-client custom headers from `DioClientConfig.headers`.
library;

abstract final class DioDefaultHeaders {
  /// JSON request and accept headers for REST API calls.
  static const Map<String, String> json = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
