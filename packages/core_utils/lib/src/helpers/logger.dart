// ignore_for_file: document_ignores, use_setters_to_change_properties

import 'package:logger/logger.dart';

/// App-wide logging gated by [isEnabled].
///
/// Call [configure] once at startup. When disabled, all methods no-op so
/// production builds avoid console noise and string formatting cost.
class AppLogger {
  AppLogger._();

  /// When false, all log methods return immediately without writing output.
  static bool isEnabled = false;

  /// Enables or disables logging. Typically tied to build flavor or env config.
  static void configure({bool isEnabled = false}) {
    AppLogger.isEnabled = isEnabled;
  }

  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  /// Trace-level log for verbose diagnostics.
  static void t(dynamic message) {
    if (!isEnabled) return;
    _logger.t(message);
  }

  /// Debug-level log for development inspection.
  static void d(dynamic message) {
    if (!isEnabled) return;
    _logger.d(message);
  }

  /// Info-level log for general runtime events.
  static void i(dynamic message) {
    if (!isEnabled) return;
    _logger.i(message);
  }

  /// Warning-level log for recoverable issues.
  static void w(dynamic message) {
    if (!isEnabled) return;
    _logger.w(message);
  }

  /// Error-level log with optional [error] and [stackTrace].
  static void e(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (!isEnabled) return;
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Fatal / unexpected error log (maps to logger `wtf` / fatal level).
  static void wtf(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (!isEnabled) return;
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
