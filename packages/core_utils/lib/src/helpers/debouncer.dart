// ignore_for_file: document_ignores, avoid_dynamic_calls

import 'dart:async';

/// Delays [run] until [duration] has passed without another call.
///
/// Each new call resets the timer. Call [dispose] when the owner is destroyed.
class Debouncer {
  Debouncer({this.duration = const Duration(milliseconds: 300)});

  /// Quiet period required before [run] executes.
  final Duration duration;

  Timer? _timer;

  /// Schedules [action] after [duration]. Cancels any pending action first.
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// Cancels a pending action without executing it.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Whether an action is waiting to fire.
  bool get isPending => _timer?.isActive ?? false;

  /// Releases the underlying timer.
  void dispose() {
    cancel();
  }
}

/// Debounces async work and returns a [Future] for the latest scheduled call.
///
/// Superseded calls complete with [StateError] on the previous future.
class AsyncDebouncer<T> {
  AsyncDebouncer({this.duration = const Duration(milliseconds: 300)});

  final Duration duration;
  Timer? _timer;
  Completer<T>? _completer;

  /// Schedules [action] after [duration]. Returns a future for this invocation.
  ///
  /// Earlier futures from rapid calls are completed with an error when superseded.
  Future<T> run(Future<T> Function() action) {
    _timer?.cancel();
    _completer?.completeError(
      StateError('Debounced: newer call superseded this one'),
    );

    _completer = Completer<T>();
    final currentCompleter = _completer!;

    _timer = Timer(duration, () async {
      try {
        final result = await action();
        if (!currentCompleter.isCompleted) {
          currentCompleter.complete(result);
        }
      } catch (e, s) {
        if (!currentCompleter.isCompleted) {
          currentCompleter.completeError(e, s);
        }
      }
    });

    return currentCompleter.future;
  }

  /// Cancels the pending timer and drops the current completer.
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _completer = null;
  }

  void dispose() {
    cancel();
  }
}

/// Creates a debounced wrapper around a zero-argument function.
///
/// Note: creates a new [Debouncer] per extension call; prefer a long-lived
/// [Debouncer] instance when the wrapper outlives a single expression.
extension DebouncerExtension on Function {
  void Function() debounced({
    Duration duration = const Duration(milliseconds: 300),
  }) {
    final debouncer = Debouncer(duration: duration);
    return () => debouncer.run(() => this());
  }
}
