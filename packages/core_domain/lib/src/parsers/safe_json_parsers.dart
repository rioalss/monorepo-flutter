/// Low-level JSON value coercion for defensive deserialization.
///
/// Accepts common API type mismatches (e.g. numeric strings, bool as int)
/// and returns null or defaults instead of throwing. Used by converters and
/// list parsing helpers.
library;

import 'package:core_domain/src/utils/safe_call.dart';

/// Safely converts a JSON value to [int].
///
/// Handles [int], [double], [String], and null. Empty strings return null.
int? safeParseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) {
    if (value.isEmpty) return null;
    return int.tryParse(value) ?? double.tryParse(value)?.toInt();
  }
  return null;
}

/// Like [safeParseInt] but returns [defaultValue] when parsing fails.
int safeParseIntOrDefault(dynamic value, [int defaultValue = 0]) =>
    safeParseInt(value) ?? defaultValue;

/// Safely converts a JSON value to [double].
///
/// Handles [double], [int], [String], and null. Empty strings return null.
double? safeParseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) {
    if (value.isEmpty) return null;
    return double.tryParse(value);
  }
  return null;
}

/// Like [safeParseDouble] but returns [defaultValue] when parsing fails.
double safeParseDoubleOrDefault(dynamic value, [double defaultValue = 0.0]) =>
    safeParseDouble(value) ?? defaultValue;

/// Safely converts a JSON value to [bool].
///
/// Handles [bool], [int] (0/1), [String] (`true`/`false`/`1`/`0`), and null.
bool? safeParseBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value != 0;
  if (value is String) {
    final lower = value.toLowerCase();
    if (lower == 'true' || lower == '1') return true;
    if (lower == 'false' || lower == '0') return false;
    return null;
  }
  return null;
}

/// Like [safeParseBool] but returns [defaultValue] when parsing fails.
// ignore: avoid_positional_boolean_parameters
bool safeParseBoolOrDefault(dynamic value, [bool defaultValue = false]) =>
    safeParseBool(value) ?? defaultValue;

/// Safely converts a JSON value to [String].
///
/// Handles [String], [int], [double], [bool], and null via `toString()`.
String? safeParseString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}

/// Like [safeParseString] but returns [defaultValue] when the value is null.
String safeParseStringOrDefault(dynamic value, [String defaultValue = '']) =>
    safeParseString(value) ?? defaultValue;

/// Safely converts a JSON value to [DateTime].
///
/// Handles [DateTime], ISO8601 [String], and [int] epoch values.
/// Integer values below `4102444800000` are treated as seconds, not milliseconds.
DateTime? safeParseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) {
    if (value.isEmpty) return null;
    return DateTime.tryParse(value);
  }
  if (value is int) {
    // Values below this threshold are treated as seconds, not milliseconds.
    if (value < 4102444800000) {
      return DateTime.fromMillisecondsSinceEpoch(value * 1000);
    }
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  return null;
}

/// Like [safeParseDateTime] but returns [defaultValue] or epoch zero on failure.
DateTime safeParseDateTimeOrDefault(
  dynamic value, [
  DateTime? defaultValue,
]) =>
    safeParseDateTime(value) ?? defaultValue ?? DateTime.fromMillisecondsSinceEpoch(0);

/// Safely converts a JSON value to [num].
///
/// Handles [num], [String], and null. Empty strings return null.
num? safeParseNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) {
    if (value.isEmpty) return null;
    return num.tryParse(value);
  }
  return null;
}

/// Like [safeParseNum] but returns [defaultValue] when parsing fails.
num safeParseNumOrDefault(dynamic value, [num defaultValue = 0]) =>
    safeParseNum(value) ?? defaultValue;

/// Safely parses a JSON list, skipping any element that fails to parse.
///
/// Returns an empty list if [jsonList] is null. Failed items are dropped
/// after logging via [safeParseModel]; use [debugLabel] to trace call sites.
List<T> safeParseList<T>(
  List<dynamic>? jsonList,
  T Function(Object? json) fromJson, {
  String? debugLabel,
}) {
  if (jsonList == null) return [];
  return jsonList
      .map((item) => safeParseModel(() => fromJson(item), debugLabel: debugLabel))
      .whereType<T>()
      .toList();
}
