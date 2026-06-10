// ignore_for_file: document_ignores, avoid_dynamic_calls

import 'dart:async';

import 'package:core_utils/core_utils.dart';

/// Limits how often an action can run within a [duration] window.
///
/// Unlike [Debouncer], the first call in a window executes immediately.
class Throttler {
  Throttler({this.duration = const Duration(milliseconds: 300)});

  /// Minimum interval between leading-edge executions.
  final Duration duration;

  Timer? _timer;
  bool _isThrottled = false;
  void Function()? _pendingAction;

  /// Runs [action] immediately unless throttled.
  ///
  /// When [trailing] is true, the last call during the throttle window runs
  /// once after the window ends.
  void run(void Function() action, {bool trailing = false}) {
    if (_isThrottled) {
      if (trailing) {
        _pendingAction = action;
      }
      return;
    }

    action();
    _isThrottled = true;

    _timer = Timer(duration, () {
      _isThrottled = false;
      if (_pendingAction != null) {
        final pending = _pendingAction!;
        _pendingAction = null;
        run(pending, trailing: trailing);
      }
    });
  }

  /// Clears throttle state and cancels any trailing execution.
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _isThrottled = false;
    _pendingAction = null;
  }

  /// Whether the throttle window is active.
  bool get isThrottled => _isThrottled;

  void dispose() {
    cancel();
  }
}

/// Throttles async calls by returning the in-flight result when called too soon.
class AsyncThrottler<T> {
  AsyncThrottler({this.duration = const Duration(milliseconds: 300)});

  final Duration duration;
  DateTime? _lastExecution;
  Future<T>? _lastResult;

  /// Runs [action] or returns the cached future if inside [duration].
  Future<T> run(Future<T> Function() action) async {
    final now = DateTime.now();

    if (_lastExecution != null) {
      final elapsed = now.difference(_lastExecution!);
      if (elapsed < duration && _lastResult != null) {
        return _lastResult!;
      }
    }

    _lastExecution = now;
    _lastResult = action();
    return _lastResult!;
  }

  /// Clears cached execution time and future.
  void reset() {
    _lastExecution = null;
    _lastResult = null;
  }
}

/// Creates a throttled wrapper. Prefer a long-lived [Throttler] for widgets.
extension ThrottlerExtension on Function {
  void Function() throttled({
    Duration duration = const Duration(milliseconds: 300),
  }) {
    final throttler = Throttler(duration: duration);
    return () => throttler.run(() => this());
  }
}
