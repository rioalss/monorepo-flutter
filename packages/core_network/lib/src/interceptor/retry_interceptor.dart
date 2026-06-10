/// Dio interceptor that retries transient request failures.
///
/// Applies exponential back-off for connection, timeout, and 5xx server errors.
/// Skips cancelled requests and 4xx client errors.
library;

import 'dart:async';

import 'package:dio/dio.dart';

/// Retries failed requests with exponential back-off.
///
/// Retries on:
/// - Connection and timeout errors
/// - 5xx server errors
///
/// Skips: request cancellation, 4xx client errors.
class RetryInterceptor extends Interceptor {
  /// Creates an interceptor that retries up to [maxRetries] times.
  ///
  /// [retryDelays] defines the wait before each attempt; the last entry is
  /// reused when retries exceed the list length.
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 4),
    ],
  });

  /// Dio instance used to replay failed requests.
  final Dio dio;

  /// Maximum number of retry attempts before propagating the error.
  final int maxRetries;

  /// Delay before each retry attempt, indexed by current retry count.
  final List<Duration> retryDelays;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRetry(err)) return handler.next(err);

    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;
    if (retryCount >= maxRetries) return handler.next(err);

    final delay = retryCount < retryDelays.length
        ? retryDelays[retryCount]
        : retryDelays.last;

    await Future<void>.delayed(delay);
    err.requestOptions.extra['retryCount'] = retryCount + 1;

    try {
      final response = await dio.request<dynamic>(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
          extra: err.requestOptions.extra,
        ),
        cancelToken: err.requestOptions.cancelToken,
      );
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  /// Returns `true` when [err] represents a transient, retryable failure.
  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.cancel) return false;
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return true;
    }
    final statusCode = err.response?.statusCode ?? 0;
    return statusCode >= 500 && statusCode < 600;
  }
}
