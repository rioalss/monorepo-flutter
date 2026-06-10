/// Riverpod notifier for paginated users list fetching.
///
/// Manages [UsersListState] and delegates to [userRepositoryProvider].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/user/riverpod/user_repository_providers.dart';
import 'package:core_state/src/features/user/state/users_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles paginated user list requests for Riverpod consumers.
class UsersListNotifier extends Notifier<UsersListState> {
  UserRepository get _repository => ref.read(userRepositoryProvider);

  @override
  UsersListState build() => const UsersListInitial();

  /// Fetches a page of users and updates [state] with the result.
  Future<void> getUsers({int page = 1, int perPage = 10}) async {
    state = const UsersListLoading();
    final result = await _repository.getUsers(page: page, perPage: perPage);
    state = switch (result) {
      AppSuccess<PaginatedResponseModel<UserModel>>(:final data) => UsersListSuccess(data),
      AppFailure<PaginatedResponseModel<UserModel>>(:final error) => UsersListFailure(
          message: error.message,
          error: error.originalError,
        ),
    };
  }
}
