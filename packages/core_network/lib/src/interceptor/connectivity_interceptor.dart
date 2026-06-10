/// Dio interceptor that rejects requests when offline.
///
/// Runs before `AuthInterceptor` so authorization headers are not attached
/// when the device has no internet access.
library;

import 'package:core_domain/core_domain.dart';
import 'package:dio/dio.dart';

/// Blocks outgoing requests when there is no internet connection.
///
/// Runs before `AuthInterceptor` so auth headers are not attached unnecessarily.
/// Rejects with `DioExceptionType.connectionError`, which `DioClient` maps to
/// `NoInternetException`.
class ConnectivityInterceptor extends Interceptor {
  /// Creates an interceptor that consults [networkInfo] before each request.
  ConnectivityInterceptor({required NetworkInfo networkInfo})
      : _networkInfo = networkInfo;

  final NetworkInfo _networkInfo;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!await _networkInfo.isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
        ),
      );
    }
    handler.next(options);
  }
}
