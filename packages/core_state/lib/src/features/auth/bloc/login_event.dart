/// BLoC events for the login feature.
///
/// Defines user actions dispatched to [LoginBloc].

library;

import 'package:flutter/foundation.dart';

/// Root type for all login-related BLoC events.
sealed class LoginEvent {
  /// Creates a login event.
  const LoginEvent();
}

/// User submitted credentials for authentication.
@immutable
final class LoginSubmitted extends LoginEvent {
  /// Creates an event with [username], [password], and optional token TTL.
  const LoginSubmitted({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });

  /// Account username or email.
  final String username;

  /// Plain-text password for the login request.
  final String password;

  /// Requested access-token lifetime in minutes; defaults to 30.
  final int expiresInMins;
}
