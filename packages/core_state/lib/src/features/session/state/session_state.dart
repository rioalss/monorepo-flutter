/// Sealed session states and pattern-matching helpers for auth gating.
///
/// Represents checking stored tokens, authenticated, and unauthenticated phases
/// used by BLoC, GetX, and Riverpod session managers.

library;

import 'package:flutter/foundation.dart';

/// Root type for all session lifecycle states.
sealed class SessionState {
  /// Creates a session state value.
  const SessionState();
}

/// Session validity is being read from persistent storage.
@immutable
final class SessionChecking extends SessionState {
  /// Default state while tokens are loaded asynchronously.
  const SessionChecking();

  @override
  bool operator ==(Object other) => other is SessionChecking;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// User has valid stored credentials.
@immutable
final class SessionAuthenticated extends SessionState {
  /// Creates an authenticated session, optionally with a resolved [userId].
  const SessionAuthenticated({this.userId});

  /// Stored user identifier; may be null if not persisted.
  final String? userId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionAuthenticated && other.userId == userId);

  @override
  int get hashCode => userId.hashCode;
}

/// No valid session is present.
@immutable
final class SessionUnauthenticated extends SessionState {
  /// Explicit logged-out or expired session.
  const SessionUnauthenticated();

  @override
  bool operator ==(Object other) => other is SessionUnauthenticated;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Convenience predicates and exhaustive matching for [SessionState].
extension SessionStateX on SessionState {
  /// Whether the session is being resolved from storage.
  bool get isChecking => this is SessionChecking;

  /// Whether the user is considered logged in.
  bool get isAuthenticated => this is SessionAuthenticated;

  /// Whether the user has no active session.
  bool get isUnauthenticated => this is SessionUnauthenticated;

  /// Returns [SessionAuthenticated.userId] or null for other states.
  String? get userIdOrNull => switch (this) {
        SessionAuthenticated(:final userId) => userId,
        _ => null,
      };

  /// Exhaustively maps each session variant to a value of type [R].
  R when<R>({
    required R Function() checking,
    required R Function(String? userId) authenticated,
    required R Function() unauthenticated,
  }) =>
      switch (this) {
        SessionChecking() => checking(),
        SessionAuthenticated(:final userId) => authenticated(userId),
        SessionUnauthenticated() => unauthenticated(),
      };
}
