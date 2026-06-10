/// Factory for constructing fully configured Dio client instances.
///
/// Each call to `DioClientFactory.create` produces an isolated Dio instance
/// with its own interceptor chain, allowing multiple base URLs to coexist.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/src/client/constant/dio_default_headers.dart';
import 'package:core_network/src/client/dio_client.dart';
import 'package:core_network/src/client/dio_client_config.dart';
import 'package:core_network/src/config/api_config.dart';
import 'package:core_network/src/connection/network_info.dart';
import 'package:core_network/src/interceptor/auth_interceptor.dart';
import 'package:core_network/src/interceptor/connectivity_interceptor.dart';
import 'package:core_network/src/interceptor/retry_interceptor.dart';
import 'package:core_storage/core_storage.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Builds [DioClient] instances with connectivity, auth, retry, and logging
/// interceptors wired according to [DioClientConfig].
///
/// Example:
/// ```dart
/// final factory = DioClientFactory();
///
/// final mainApi = factory.create(
///   config: ApiConfig.defaultConfig(),
///   tokenStorage: tokenStorage,
/// );
/// ```
class DioClientFactory {
  /// Creates a stateless factory instance.
  const DioClientFactory();

  /// Assembles a [DioClient] with interceptors derived from [config].
  ///
  /// [tokenStorage] is required when [DioClientConfig.enableAuth] is `true`.
  /// [networkInfo] defaults to [defaultNetworkInfo] when omitted.
  /// [onSessionInvalidated] is invoked after a failed token refresh clears
  /// stored credentials.
  /// [extraInterceptors] are appended after the built-in interceptors.
  DioClient create({
    required DioClientConfig config,
    required TokenStorage tokenStorage,
    NetworkInfo? networkInfo,
    void Function()? onSessionInvalidated,
    List<Interceptor> extraInterceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        sendTimeout: config.sendTimeout,
        headers: {
          ...DioDefaultHeaders.json,
          ...config.headers,
        },
      ),
    );

    dio.interceptors.add(
      ConnectivityInterceptor(
        networkInfo: networkInfo ?? defaultNetworkInfo,
      ),
    );

    if (config.enableAuth) {
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          tokenStorage: tokenStorage,
          publicPaths: config.publicPaths,
          onSessionInvalidated: onSessionInvalidated,
        ),
      );
    }

    if (config.maxRetryAttempts > 0) {
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
          maxRetries: config.maxRetryAttempts,
        ),
      );
    }

    if (config.enableLogging && !ApiConfig.isProduction) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          maxWidth: 120,
        ),
      );
    }

    dio.interceptors.addAll(extraInterceptors);

    return DioClient(dio: dio);
  }
}
