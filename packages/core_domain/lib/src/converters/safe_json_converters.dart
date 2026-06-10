/// JsonConverter implementations that tolerate malformed API JSON values.
///
/// Delegates to safe JSON parser functions so Freezed/json_serializable models
/// deserialize without throwing on unexpected types or nulls.
library;

import 'package:core_domain/src/parsers/safe_json_parsers.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converts JSON to non-null [int], defaulting invalid values to `0`.
class SafeIntConverter implements JsonConverter<int, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeIntConverter();

  @override
  int fromJson(dynamic json) => safeParseIntOrDefault(json);

  @override
  dynamic toJson(int object) => object;
}

/// Converts JSON to nullable [int], returning null for invalid values.
class SafeNullableIntConverter implements JsonConverter<int?, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeNullableIntConverter();

  @override
  int? fromJson(dynamic json) => safeParseInt(json);

  @override
  dynamic toJson(int? object) => object;
}

/// Converts JSON to non-null [double], defaulting invalid values to `0.0`.
class SafeDoubleConverter implements JsonConverter<double, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeDoubleConverter();

  @override
  double fromJson(dynamic json) => safeParseDoubleOrDefault(json);

  @override
  dynamic toJson(double object) => object;
}

/// Converts JSON to nullable [double], returning null for invalid values.
class SafeNullableDoubleConverter implements JsonConverter<double?, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeNullableDoubleConverter();

  @override
  double? fromJson(dynamic json) => safeParseDouble(json);

  @override
  dynamic toJson(double? object) => object;
}

/// Converts JSON to non-null [num], defaulting invalid values to `0`.
class SafeNumConverter implements JsonConverter<num, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeNumConverter();

  @override
  num fromJson(dynamic json) => safeParseNumOrDefault(json);

  @override
  dynamic toJson(num object) => object;
}

/// Converts JSON to nullable [num], returning null for invalid values.
class SafeNullableNumConverter implements JsonConverter<num?, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeNullableNumConverter();

  @override
  num? fromJson(dynamic json) => safeParseNum(json);

  @override
  dynamic toJson(num? object) => object;
}

/// Converts JSON to non-null [bool], defaulting invalid values to `false`.
class SafeBoolConverter implements JsonConverter<bool, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeBoolConverter();

  @override
  bool fromJson(dynamic json) => safeParseBoolOrDefault(json);

  @override
  dynamic toJson(bool object) => object;
}

/// Converts JSON to nullable [bool], returning null for invalid values.
class SafeNullableBoolConverter implements JsonConverter<bool?, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeNullableBoolConverter();

  @override
  bool? fromJson(dynamic json) => safeParseBool(json);

  @override
  dynamic toJson(bool? object) => object;
}

/// Converts JSON to non-null [String], defaulting invalid values to `''`.
class SafeStringConverter implements JsonConverter<String, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeStringConverter();

  @override
  String fromJson(dynamic json) => safeParseStringOrDefault(json);

  @override
  dynamic toJson(String object) => object;
}

/// Converts JSON to nullable [String], returning null for invalid values.
class SafeNullableStringConverter implements JsonConverter<String?, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeNullableStringConverter();

  @override
  String? fromJson(dynamic json) => safeParseString(json);

  @override
  dynamic toJson(String? object) => object;
}

/// Converts JSON to nullable [DateTime] from ISO strings or epoch values.
class SafeDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) => safeParseDateTime(json);

  @override
  dynamic toJson(DateTime? object) => object?.toIso8601String();
}

/// Converts JSON to non-null [DateTime], using epoch zero when parsing fails.
class SafeDateTimeRequiredConverter implements JsonConverter<DateTime, dynamic> {
  /// Creates a const converter instance for field annotations.
  const SafeDateTimeRequiredConverter();

  @override
  DateTime fromJson(dynamic json) =>
      safeParseDateTime(json) ?? DateTime.fromMillisecondsSinceEpoch(0);

  @override
  dynamic toJson(DateTime object) => object.toIso8601String();
}

/// Base class for type-safe enum JSON converters.
///
/// Create a const subclass per enum and annotate fields with it:
/// ```dart
/// class StatusConverter extends SafeEnumConverter<Status> {
///   const StatusConverter() : super(const [Status.active, Status.inactive]);
/// }
///
/// @freezed
/// abstract class MyModel with _$MyModel {
///   const factory MyModel({@StatusConverter() Status? status}) = _MyModel;
/// }
/// ```
abstract class SafeEnumConverter<T extends Enum>
    implements JsonConverter<T?, dynamic> {
  /// Creates a converter that matches JSON strings to [values] case-insensitively.
  const SafeEnumConverter(this.values);

  /// All enum constants eligible for deserialization.
  final List<T> values;

  @override
  T? fromJson(dynamic json) {
    if (json == null) return null;
    final str = json.toString().toLowerCase();
    for (final value in values) {
      if (value.name.toLowerCase() == str) return value;
    }
    return null;
  }

  @override
  dynamic toJson(T? object) => object?.name;
}
