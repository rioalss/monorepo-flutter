/// Generic API response envelope for typed payloads.
///
/// Wraps success flag, message, data, error, and optional pagination meta.
/// Used by data sources before mapping to domain result types.
library;

import 'package:core_domain/src/converters/safe_json_converters.dart';
import 'package:core_domain/src/models/response/api_error_model.dart';
import 'package:core_domain/src/models/response/paginated_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_model.freezed.dart';
part 'api_response_model.g.dart';

/// Generic wrapper for all API responses.
@Freezed(genericArgumentFactories: true)
abstract class ApiResponseModel<T> with _$ApiResponseModel<T> {
  /// Creates an API response with optional typed [data] and [error].
  const factory ApiResponseModel({
    @SafeBoolConverter() @Default(false) bool success,
    @SafeNullableStringConverter() String? message,
    T? data,
    ApiErrorModel? error,
    PaginatedMetaModel? meta,
  }) = _ApiResponseModel<T>;

  /// Deserializes from JSON using [fromJsonT] to parse the [data] field.
  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseModelFromJson(json, fromJsonT);
}
