/// Riverpod providers for user detail and list notifiers.
///
/// Re-exports user repository providers and exposes [userDetailProvider] and
/// [usersListProvider] for UI consumption.

library;

import 'package:core_state/src/features/user/riverpod/user_detail_notifier.dart';
import 'package:core_state/src/features/user/riverpod/users_list_notifier.dart';
import 'package:core_state/src/features/user/state/user_detail_state.dart';
import 'package:core_state/src/features/user/state/users_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:core_state/src/features/user/riverpod/user_repository_providers.dart';

/// Global user detail state provider for Riverpod apps.
final userDetailProvider = NotifierProvider<UserDetailNotifier, UserDetailState>(
  UserDetailNotifier.new,
);

/// Global paginated users list state provider for Riverpod apps.
final usersListProvider = NotifierProvider<UsersListNotifier, UsersListState>(
  UsersListNotifier.new,
);
