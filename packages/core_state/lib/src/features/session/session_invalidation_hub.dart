/// Callback bridge from network auth interceptor to app session state.
///
/// Register [onInvalidated] from a session manager; call [notify] when tokens
/// are cleared remotely or by the interceptor.

library;

class SessionInvalidationHub {
  /// Handler invoked when the session is invalidated externally.
  ///
  /// No-op when null.
  void Function()? onInvalidated;

  /// Notifies listeners that the current session is no longer valid.
  void notify() => onInvalidated?.call();
}
