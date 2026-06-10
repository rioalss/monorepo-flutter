/// Riverpod notifier for single-user profile fetching.
///
/// Manages [UserDetailState] and delegates to [userRepositoryProvider].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/user/riverpod/user_repository_providers.dart';
import 'package:core_state/src/features/user/state/user_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles single-user profile requests for Riverpod consumers.
class UserDetailNotifier extends Notifier<UserDetailState> {
  UserRepository get _repository => ref.read(userRepositoryProvider);

  @override
  UserDetailState build() => const UserDetailInitial();

  /// Loads [userId] and updates [state] with the result.
  Future<void> getUserById(String userId) async {
    state = const UserDetailLoading();
    final result = await _repository.getUserById(userId);
    state = switch (result) {
      AppSuccess<UserModel>(:final data) => UserDetailSuccess(data),
      AppFailure<UserModel>(:final error) => UserDetailFailure(
          message: error.message,
          error: error.originalError,
        ),
    };
  }
}
