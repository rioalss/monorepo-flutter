/// Utilities for extracting human-readable messages from API error bodies.
///
/// Supports common REST error shapes including nested maps, field validation
/// lists, and plain string responses.
library;

import 'package:core_domain/core_domain.dart';

/// Extracts a human-readable message from API error response bodies.
abstract final class DioErrorBodyParser {
  const DioErrorBodyParser._();

  /// Parses [body] from a failed HTTP response into a display message.
  ///
  /// Supports common shapes: `message`, `error` (string or nested map),
  /// `errors` (list of strings, list of maps, or field map).
  /// Returns `null` when no meaningful message can be extracted.
  static String? extractMessage(dynamic body) {
    if (body == null) return null;
    if (body is String) {
      return body.isEmpty ? null : body;
    }
    if (body is List) {
      return _extractFromList(body);
    }
    if (body is Map) {
      return _extractFromMap(Map<String, dynamic>.from(body));
    }
    final text = body.toString();
    return text.isEmpty ? null : text;
  }

  /// Extracts a message from a JSON object error body.
  ///
  /// Checks `message`, `error`, `errors`, and `detail` keys in order.
  static String? _extractFromMap(Map<String, dynamic> map) {
    final message = safeParseString(map['message']);
    if (message != null && message.isNotEmpty) return message;

    final errorField = map['error'];
    final fromError = _extractErrorField(errorField);
    if (fromError != null && fromError.isNotEmpty) return fromError;

    final errorsField = map['errors'];
    final fromErrors = _extractErrorsField(errorsField);
    if (fromErrors != null && fromErrors.isNotEmpty) return fromErrors;

    final detail = safeParseString(map['detail']);
    if (detail != null && detail.isNotEmpty) return detail;

    return null;
  }

  /// Parses the `error` field, including nested map shapes.
  static String? _extractErrorField(dynamic errorField) {
    if (errorField == null) return null;
    if (errorField is String) {
      return errorField.isEmpty ? null : errorField;
    }
    if (errorField is Map) {
      final map = Map<String, dynamic>.from(errorField);
      final nestedMessage = safeParseString(map['message']);
      if (nestedMessage != null && nestedMessage.isNotEmpty) {
        return nestedMessage;
      }
      final nestedError = safeParseString(map['error']);
      if (nestedError != null && nestedError.isNotEmpty) return nestedError;
    }
    return errorField.toString();
  }

  /// Parses the `errors` field as a list or field-validation map.
  static String? _extractErrorsField(dynamic errorsField) {
    if (errorsField == null) return null;
    if (errorsField is List) return _extractFromList(errorsField);
    if (errorsField is Map) {
      return _flattenFieldErrors(Map<String, dynamic>.from(errorsField));
    }
    return errorsField.toString();
  }

  /// Joins string or map entries from a list of error items.
  static String? _extractFromList(List<dynamic> list) {
    if (list.isEmpty) return null;
    final parts = <String>[];
    for (final item in list) {
      if (item is String && item.isNotEmpty) {
        parts.add(item);
      } else if (item is Map) {
        final map = Map<String, dynamic>.from(item);
        final msg = safeParseString(map['message']) ??
            safeParseString(map['error']) ??
            safeParseString(map['detail']);
        if (msg != null && msg.isNotEmpty) {
          parts.add(msg);
        }
      }
    }
    return parts.isEmpty ? null : parts.join('; ');
  }

  /// Flattens per-field validation errors into a single message.
  static String? _flattenFieldErrors(Map<String, dynamic> fieldErrors) {
    final parts = <String>[];
    for (final entry in fieldErrors.entries) {
      final value = entry.value;
      if (value is List) {
        for (final item in value) {
          final text = safeParseString(item);
          if (text != null && text.isNotEmpty) {
            parts.add('${entry.key}: $text');
          }
        }
      } else {
        final text = safeParseString(value);
        if (text != null && text.isNotEmpty) {
          parts.add('${entry.key}: $text');
        }
      }
    }
    return parts.isEmpty ? null : parts.join('; ');
  }
}
