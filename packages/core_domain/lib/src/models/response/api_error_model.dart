/// Structured API error payload from backend responses.
///
/// Captures HTTP status, message, and field-level validation errors.
/// Deserialized from JSON using safe converters for resilient parsing.
library;

import 'package:core_domain/src/converters/safe_json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error_model.freezed.dart';
part 'api_error_model.g.dart';

/// Error body nested inside API response envelopes on failed requests.
@freezed
abstract class ApiErrorModel with _$ApiErrorModel {
  /// Creates an API error with optional status, message, and field errors.
  ///
  /// [errors] maps field names to lists of validation messages when present.
  const factory ApiErrorModel({
    @SafeNullableIntConverter() int? statusCode,
    @SafeNullableStringConverter() String? message,
    Map<String, List<String>>? errors,
  }) = _ApiErrorModel;

  /// Deserializes from a JSON map.
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);
}
