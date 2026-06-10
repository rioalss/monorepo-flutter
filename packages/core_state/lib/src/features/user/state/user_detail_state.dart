/// Sealed single-user detail states and pattern-matching helpers.
///
/// Models idle, loading, success, and failure phases for fetching one user
/// across BLoC, GetX, and Riverpod.

library;

import 'package:core_domain/core_domain.dart';
import 'package:flutter/foundation.dart';

/// Root type for all user-detail operation states.
sealed class UserDetailState {
  /// Creates a user-detail state value.
  const UserDetailState();
}

/// No detail fetch has been requested or state was reset.
@immutable
final class UserDetailInitial extends UserDetailState {
  /// Default state before the first request.
  const UserDetailInitial();

  @override
  bool operator ==(Object other) => other is UserDetailInitial;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A single-user request is in flight.
@immutable
final class UserDetailLoading extends UserDetailState {
  /// Emitted while [UserRepository.getUserById] is running.
  const UserDetailLoading();

  @override
  bool operator ==(Object other) => other is UserDetailLoading;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// User profile loaded successfully.
@immutable
final class UserDetailSuccess extends UserDetailState {
  /// Creates a success state with the fetched [user].
  const UserDetailSuccess(this.user);

  /// User profile returned by the API.
  final UserModel user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDetailSuccess && other.user == user);

  @override
  int get hashCode => user.hashCode;
}

/// User detail fetch failed with a user-facing message.
@immutable
final class UserDetailFailure extends UserDetailState {
  /// Creates a failure state with [message] and optional underlying [error].
  const UserDetailFailure({required this.message, this.error});

  /// Human-readable error description for UI display.
  final String message;

  /// Original exception or error object when available.
  final Object? error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDetailFailure && other.message == message);

  @override
  int get hashCode => message.hashCode;
}

/// Convenience predicates and exhaustive matching for [UserDetailState].
extension UserDetailStateX on UserDetailState {
  /// Whether no detail fetch is in progress.
  bool get isInitial => this is UserDetailInitial;

  /// Whether a detail request is active.
  bool get isLoading => this is UserDetailLoading;

  /// Whether the profile loaded successfully.
  bool get isSuccess => this is UserDetailSuccess;

  /// Whether the detail fetch failed.
  bool get isFailure => this is UserDetailFailure;

  /// Returns [UserDetailSuccess.user] or null for other states.
  UserModel? get userOrNull => switch (this) {
        UserDetailSuccess(:final user) => user,
        _ => null,
      };

  /// Returns [UserDetailFailure.message] or null for other states.
  String? get errorMessageOrNull => switch (this) {
        UserDetailFailure(:final message) => message,
        _ => null,
      };

  /// Exhaustively maps each detail variant to a value of type [R].
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(UserModel user) success,
    required R Function(String message, Object? error) failure,
  }) =>
      switch (this) {
        UserDetailInitial() => initial(),
        UserDetailLoading() => loading(),
        UserDetailSuccess(:final user) => success(user),
        UserDetailFailure(:final message, error: final rawError) =>
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
        UserDetailInitial() => initial?.call() ?? orElse(),
        UserDetailLoading() => loading?.call() ?? orElse(),
        UserDetailSuccess(:final user) => success?.call(user) ?? orElse(),
        UserDetailFailure(:final message, error: final rawError) =>
          failure?.call(message, rawError) ?? orElse(),
      };
}
