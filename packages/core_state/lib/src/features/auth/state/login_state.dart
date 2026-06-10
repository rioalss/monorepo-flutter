/// Sealed login flow states and pattern-matching helpers.
///
/// Models idle, loading, success, and failure phases for username/password
/// authentication across BLoC, GetX, and Riverpod.

library;

import 'package:core_domain/core_domain.dart';
import 'package:flutter/foundation.dart';

/// Root type for all login operation states.
sealed class LoginState {
  /// Creates a login state value.
  const LoginState();
}

/// Login has not been attempted or was reset.
@immutable
final class LoginInitial extends LoginState {
  /// Default state before the first submission.
  const LoginInitial();

  @override
  bool operator ==(Object other) => other is LoginInitial;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Credentials are being validated remotely.
@immutable
final class LoginLoading extends LoginState {
  /// Emitted while the login request is in flight.
  const LoginLoading();

  @override
  bool operator ==(Object other) => other is LoginLoading;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Login succeeded and returned a session.
@immutable
final class LoginSuccess extends LoginState {
  /// Creates a success state with the authenticated [session].
  const LoginSuccess(this.session);

  /// Tokens and user metadata from the auth API.
  final AuthSessionModel session;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginSuccess && other.session == session);

  @override
  int get hashCode => session.hashCode;
}

/// Login failed with a user-facing message.
@immutable
final class LoginFailure extends LoginState {
  /// Creates a failure state with [message] and optional underlying [error].
  const LoginFailure({required this.message, this.error});

  /// Human-readable error description for UI display.
  final String message;

  /// Original exception or error object when available.
  final Object? error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginFailure && other.message == message);

  @override
  int get hashCode => message.hashCode;
}

/// Convenience predicates and exhaustive matching for [LoginState].
extension LoginStateX on LoginState {
  /// Whether no login attempt is in progress.
  bool get isInitial => this is LoginInitial;

  /// Whether a login request is active.
  bool get isLoading => this is LoginLoading;

  /// Whether login completed successfully.
  bool get isSuccess => this is LoginSuccess;

  /// Whether login failed.
  bool get isFailure => this is LoginFailure;

  /// Returns [LoginSuccess.session] or null for other states.
  AuthSessionModel? get sessionOrNull => switch (this) {
        LoginSuccess(:final session) => session,
        _ => null,
      };

  /// Returns [LoginFailure.message] or null for other states.
  String? get errorMessageOrNull => switch (this) {
        LoginFailure(:final message) => message,
        _ => null,
      };

  /// Exhaustively maps each login variant to a value of type [R].
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(AuthSessionModel session) success,
    required R Function(String message, Object? error) failure,
  }) =>
      switch (this) {
        LoginInitial() => initial(),
        LoginLoading() => loading(),
        LoginSuccess(:final session) => success(session),
        LoginFailure(:final message, error: final rawError) =>
          failure(message, rawError),
      };

  /// Maps known variants when handlers are provided; otherwise calls [orElse].
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? initial,
    R Function()? loading,
    R Function(AuthSessionModel session)? success,
    R Function(String message, Object? error)? failure,
  }) =>
      switch (this) {
        LoginInitial() => initial?.call() ?? orElse(),
        LoginLoading() => loading?.call() ?? orElse(),
        LoginSuccess(:final session) => success?.call(session) ?? orElse(),
        LoginFailure(:final message, error: final rawError) =>
          failure?.call(message, rawError) ?? orElse(),
      };
}
