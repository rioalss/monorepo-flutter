/// GetX controller for single-user profile fetching.
///
/// Exposes reactive [UserDetailState] and delegates to [UserRepository].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/user/state/user_detail_state.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// Reactive user detail manager for GetX apps.
@injectable
class UserDetailController extends GetxController {
  /// Creates a controller backed by [repository].
  UserDetailController(this._repository);

  final UserRepository _repository;
  final _state = Rx<UserDetailState>(const UserDetailInitial());

  /// Current detail snapshot for UI binding.
  UserDetailState get state => _state.value;

  /// Loads [userId] and updates [state] with the result.
  Future<void> getUserById(String userId) async {
    _state.value = const UserDetailLoading();
    final result = await _repository.getUserById(userId);
    _state.value = switch (result) {
      AppSuccess<UserModel>(:final data) => UserDetailSuccess(data),
      AppFailure<UserModel>(:final error) => UserDetailFailure(
          message: error.message,
          error: error.originalError,
        ),
    };
  }
}
