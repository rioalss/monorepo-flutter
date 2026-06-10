/// BLoC events for the paginated users list feature.
///
/// Defines user actions dispatched to [UsersListBloc].

library;

import 'package:flutter/foundation.dart';

/// Root type for all users-list-related BLoC events.
sealed class UsersListEvent {
  /// Creates a users-list event.
  const UsersListEvent();
}

/// User requested a page of users from the API.
@immutable
final class UsersListRequested extends UsersListEvent {
  /// Creates an event with optional [page] and [perPage] query parameters.
  const UsersListRequested({
    this.page = 1,
    this.perPage = 10,
  });

  /// One-based page index; defaults to 1.
  final int page;

  /// Maximum items per page; defaults to 10.
  final int perPage;
}
