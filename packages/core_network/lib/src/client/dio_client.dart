/// Thin HTTP wrapper around Dio with typed exception mapping.
///
/// Instances are created via `DioClientFactory.create`; each owns an isolated
/// Dio instance and interceptor chain.
library;

import 'package:core_network/src/exception/exceptions.dart';
import 'package:dio/dio.dart';

/// Thin HTTP wrapper around [Dio].
///
/// Create instances via `DioClientFactory.create` rather than directly.
/// Each instance owns its own [Dio] instance with its own interceptor chain.
class DioClient {
  /// Creates a client wrapping the given configured [dio] instance.
  DioClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  /// Sends a GET request and returns the decoded response body.
  ///
  /// Throws typed exceptions from [_handleDioError] on failure.
  /// Returns `null` when the server responds with an empty body.
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Sends a POST request and returns the decoded response body.
  ///
  /// [data] is serialized as the request body when provided.
  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Sends a PUT request and returns the decoded response body.
  ///
  /// [data] is serialized as the request body when provided.
  Future<dynamic> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Sends a DELETE request and returns the decoded response body.
  ///
  /// [data] is serialized as the request body when provided.
  Future<dynamic> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Sends a request with an arbitrary HTTP [method] and returns the body.
  ///
  /// Defaults to `GET` when [method] is omitted.
  Future<dynamic> request(
    String uri, {
    String method = 'GET',
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.request<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(method: method) ?? Options(method: method),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Maps [DioException] types to package-specific [Exception] subclasses.
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeoutException(e.message);
      case DioExceptionType.sendTimeout:
        return SendTimeoutException(e.message);
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeoutException(e.message);
      case DioExceptionType.badResponse:
        final raw = e.response?.data;
        final statusCode = e.response?.statusCode ?? 0;
        return BadResponseException(statusCode, raw);
      case DioExceptionType.cancel:
        return RequestCancelledException(e.message);
      case DioExceptionType.connectionError:
        return NoInternetException();
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        return UnknownApiException(e.message);
    }
  }
}
