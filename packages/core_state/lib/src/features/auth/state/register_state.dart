/// Sealed registration flow states and pattern-matching helpers.
///
/// Models idle, loading, success, and failure phases for user registration
/// across BLoC, GetX, and Riverpod.

library;

import 'package:core_domain/core_domain.dart';
import 'package:flutter/foundation.dart';

/// Root type for all registration operation states.
sealed class RegisterState {
  /// Creates a registration state value.
  const RegisterState();
}

/// Registration has not been attempted or was reset.
@immutable
final class RegisterInitial extends RegisterState {
  /// Default state before the first submission.
  const RegisterInitial();

  @override
  bool operator ==(Object other) => other is RegisterInitial;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Registration payload is being submitted remotely.
@immutable
final class RegisterLoading extends RegisterState {
  /// Emitted while the register request is in flight.
  const RegisterLoading();

  @override
  bool operator ==(Object other) => other is RegisterLoading;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Registration succeeded and returned a user profile.
@immutable
final class RegisterSuccess extends RegisterState {
  /// Creates a success state with the newly registered [user].
  const RegisterSuccess(this.user);

  /// User profile returned by the auth API.
  final UserModel user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisterSuccess && other.user == user);

  @override
  int get hashCode => user.hashCode;
}

/// Registration failed with a user-facing message.
@immutable
final class RegisterFailure extends RegisterState {
  /// Creates a failure state with [message] and optional underlying [error].
  const RegisterFailure({required this.message, this.error});

  /// Human-readable error description for UI display.
  final String message;

  /// Original exception or error object when available.
  final Object? error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisterFailure && other.message == message);

  @override
  int get hashCode => message.hashCode;
}

/// Convenience predicates and exhaustive matching for [RegisterState].
extension RegisterStateX on RegisterState {
  /// Whether no registration attempt is in progress.
  bool get isInitial => this is RegisterInitial;

  /// Whether a registration request is active.
  bool get isLoading => this is RegisterLoading;

  /// Whether registration completed successfully.
  bool get isSuccess => this is RegisterSuccess;

  /// Whether registration failed.
  bool get isFailure => this is RegisterFailure;

  /// Returns [RegisterSuccess.user] or null for other states.
  UserModel? get userOrNull => switch (this) {
        RegisterSuccess(:final user) => user,
        _ => null,
      };

  /// Returns [RegisterFailure.message] or null for other states.
  String? get errorMessageOrNull => switch (this) {
        RegisterFailure(:final message) => message,
        _ => null,
      };

  /// Exhaustively maps each registration variant to a value of type [R].
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(UserModel user) success,
    required R Function(String message, Object? error) failure,
  }) =>
      switch (this) {
        RegisterInitial() => initial(),
        RegisterLoading() => loading(),
        RegisterSuccess(:final user) => success(user),
        RegisterFailure(:final message, error: final rawError) =>
          failure(message, rawError),
      };

  /// Maps known variants when handlers are provided; otherwise calls [orElse].
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? initial,
    R Function()? loading,
    R Function(UserModel user)? success,
    R Function(String message, Object? error)? failure,
  }) =>
      switch (this) {
        RegisterInitial() => initial?.call() ?? orElse(),
        RegisterLoading() => loading?.call() ?? orElse(),
        RegisterSuccess(:final user) => success?.call(user) ?? orElse(),
        RegisterFailure(:final message, error: final rawError) =>
          failure?.call(message, rawError) ?? orElse(),
      };
}
