/// Base class for typed HTTP API services built on `DioClient`.
///
/// Provides uniform request execution and response envelope parsing so feature
/// services can focus on endpoint paths and model deserialization.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/src/client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Base class for all API services.
///
/// Extend this class in your feature packages to get uniform response parsing.
/// Connectivity is checked by `ConnectivityInterceptor` before requests leave Dio.
///
/// Network exceptions from `DioClient` propagate to the caller — wrap them
/// using `ExceptionMapper` in your repository's `AppResult` pattern:
/// ```dart
/// Future<AppResult<UserModel>> signIn(...) async {
///   try {
///     final resp = await _service.signIn(...);
///     return AppSuccess(resp.data!);
///   } on Object catch (e) {
///     return AppFailure(ExceptionMapper.map(e));
///   }
/// }
/// ```
abstract class BaseApiService {
  /// Creates a service backed by the given [client].
  const BaseApiService({required DioClient client}) : _client = client;

  final DioClient _client;

  /// The underlying HTTP client used by HTTP verb helpers.
  @protected
  DioClient get client => _client;

  /// Sends a GET request and parses the response into [ApiResponseModel].
  ///
  /// [fromJson] deserializes the payload or envelope `data` field.
  /// Network errors propagate as typed exceptions from [DioClient].
  Future<ApiResponseModel<T>> get<T>(
    String path, {
    required T Function(Object? json) fromJson,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _execute(
        () => _client.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        fromJson: fromJson,
        debugLabel: 'GET $path',
      );

  /// Sends a POST request and parses the response into [ApiResponseModel].
  ///
  /// [data] is serialized as the request body when provided.
  Future<ApiResponseModel<T>> post<T>(
    String path, {
    required T Function(Object? json) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _execute(
        () => _client.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        fromJson: fromJson,
        debugLabel: 'POST $path',
      );

  /// Sends a PUT request and parses the response into [ApiResponseModel].
  ///
  /// [data] is serialized as the request body when provided.
  Future<ApiResponseModel<T>> put<T>(
    String path, {
    required T Function(Object? json) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _execute(
        () => _client.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        fromJson: fromJson,
        debugLabel: 'PUT $path',
      );

  /// Sends a DELETE request and parses the response into [ApiResponseModel].
  ///
  /// [data] is serialized as the request body when provided.
  Future<ApiResponseModel<T>> delete<T>(
    String path, {
    required T Function(Object? json) fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _execute(
        () => _client.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        fromJson: fromJson,
        debugLabel: 'DELETE $path',
      );

  /// Executes [request], parses the raw body, and returns a safe fallback on
  /// deserialization failure.
  Future<ApiResponseModel<T>> _execute<T>(
    Future<dynamic> Function() request, {
    required T Function(Object? json) fromJson,
    required String debugLabel,
  }) async {
    final raw = await request();
    return safeParseModelOrDefault(
      () => _parseResponse(raw, fromJson),
      ApiResponseModel<T>(message: 'Failed to parse response'),
      debugLabel: debugLabel,
    );
  }

  /// Detects API envelope shapes and delegates parsing to [fromJson].
  ///
  /// Non-map bodies are treated as raw data. Map bodies without envelope keys
  /// are also passed directly to [fromJson].
  ApiResponseModel<T> _parseResponse<T>(
    dynamic raw,
    T Function(Object? json) fromJson,
  ) {
    if (raw is! Map<String, dynamic>) {
      return ApiResponseModel<T>(
        success: true,
        data: fromJson(raw),
      );
    }

    final hasEnvelope = raw.containsKey('data') &&
        (raw.containsKey('success') ||
            raw.containsKey('error') ||
            raw.containsKey('message'));

    if (hasEnvelope) {
      return ApiResponseModel.fromJson(raw, fromJson);
    }

    return ApiResponseModel<T>(
      success: true,
      data: fromJson(raw),
    );
  }
}
