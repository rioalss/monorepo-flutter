/// Safe execution helpers for model parsing and deserialization.
///
/// Wraps potentially throwing code so callers receive null or defaults instead
/// of propagating exceptions. Errors are logged via `dart:developer`.
library;

import 'dart:developer' as dev;

/// Attempts to run [fromJson] and returns the result, or null on any error.
///
/// All exceptions and errors are swallowed and logged via `dart:developer`.
/// Use [debugLabel] to identify the call site in logs.
T? safeParseModel<T>(T Function() fromJson, {String? debugLabel}) {
  try {
    return fromJson();
  } on Object catch (e, stack) {
    dev.log(
      'safeParseModel error${debugLabel != null ? ' [$debugLabel]' : ''}: $e',
      error: e,
      stackTrace: stack,
      name: 'core_domain',
    );
    return null;
  }
}

/// Like [safeParseModel] but returns [defaultValue] instead of null on failure.
T safeParseModelOrDefault<T>(
  T Function() fromJson,
  T defaultValue, {
  String? debugLabel,
}) =>
    safeParseModel(fromJson, debugLabel: debugLabel) ?? defaultValue;
