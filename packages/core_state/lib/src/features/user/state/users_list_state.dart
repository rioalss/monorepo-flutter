/// Sealed paginated users list states and pattern-matching helpers.
///
/// Models idle, loading, success, and failure phases for fetching user lists
/// across BLoC, GetX, and Riverpod.

library;

import 'package:core_domain/core_domain.dart';
import 'package:flutter/foundation.dart';

/// Root type for all users-list operation states.
sealed class UsersListState {
  /// Creates a users-list state value.
  const UsersListState();
}

/// No list fetch has been requested or state was reset.
@immutable
final class UsersListInitial extends UsersListState {
  /// Default state before the first request.
  const UsersListInitial();

  @override
  bool operator ==(Object other) => other is UsersListInitial;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A paginated users request is in flight.
@immutable
final class UsersListLoading extends UsersListState {
  /// Emitted while [UserRepository.getUsers] is running.
  const UsersListLoading();

  @override
  bool operator ==(Object other) => other is UsersListLoading;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Users list loaded successfully with pagination metadata.
@immutable
final class UsersListSuccess extends UsersListState {
  /// Creates a success state with the fetched [page].
  const UsersListSuccess(this.page);

  /// Items and pagination meta returned by the API.
  final PaginatedResponseModel<UserModel> page;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersListSuccess && other.page == page);

  @override
  int get hashCode => page.hashCode;
}

/// Users list fetch failed with a user-facing message.
@immutable
final class UsersListFailure extends UsersListState {
  /// Creates a failure state with [message] and optional underlying [error].
  const UsersListFailure({required this.message, this.error});

  /// Human-readable error description for UI display.
  final String message;

  /// Original exception or error object when available.
  final Object? error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersListFailure && other.message == message);

  @override
  int get hashCode => message.hashCode;
}

/// Convenience predicates and exhaustive matching for [UsersListState].
extension UsersListStateX on UsersListState {
  /// Whether no list fetch is in progress.
  bool get isInitial => this is UsersListInitial;

  /// Whether a list request is active.
  bool get isLoading => this is UsersListLoading;

  /// Whether the list loaded successfully.
  bool get isSuccess => this is UsersListSuccess;

  /// Whether the list fetch failed.
  bool get isFailure => this is UsersListFailure;

  /// Returns [UsersListSuccess.page] or null for other states.
  PaginatedResponseModel<UserModel>? get pageOrNull => switch (this) {
        UsersListSuccess(:final page) => page,
        _ => null,
      };

  /// Returns [UsersListFailure.message] or null for other states.
  String? get errorMessageOrNull => switch (this) {
        UsersListFailure(:final message) => message,
        _ => null,
      };

  /// Exhaustively maps each list variant to a value of type [R].
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(PaginatedResponseModel<UserModel> page) success,
    required R Function(String message, Object? error) failure,
  }) =>
      switch (this) {
        UsersListInitial() => initial(),
        UsersListLoading() => loading(),
        UsersListSuccess(:final page) => success(page),
        UsersListFailure(:final message, error: final rawError) =>
          failure(message, rawError),
      };

  /// Maps known variants when handlers are provided; otherwise calls [orElse].
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? initial,
    R Function()? loading,
    R Function(PaginatedResponseModel<UserModel> page)? success,
    R Function(String message, Object? error)? failure,
  }) =>
      switch (this) {
        UsersListInitial() => initial?.call() ?? orElse(),
        UsersListLoading() => loading?.call() ?? orElse(),
        UsersListSuccess(:final page) => success?.call(page) ?? orElse(),
        UsersListFailure(:final message, error: final rawError) =>
          failure?.call(message, rawError) ?? orElse(),
      };
}
