/// BLoC events for the single-user detail feature.
///
/// Defines user actions dispatched to [UserDetailBloc].

library;

import 'package:flutter/foundation.dart';

/// Root type for all user-detail-related BLoC events.
sealed class UserDetailEvent {
  /// Creates a user-detail event.
  const UserDetailEvent();
}

/// User requested profile data for a specific account.
@immutable
final class UserDetailRequested extends UserDetailEvent {
  /// Creates an event targeting [userId].
  const UserDetailRequested(this.userId);

  /// Identifier of the user to load.
  final String userId;
}
