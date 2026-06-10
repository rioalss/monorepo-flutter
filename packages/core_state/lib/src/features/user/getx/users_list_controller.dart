/// GetX controller for paginated users list fetching.
///
/// Exposes reactive [UsersListState] and delegates to [UserRepository].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/user/state/users_list_state.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// Reactive paginated users list manager for GetX apps.
@injectable
class UsersListController extends GetxController {
  /// Creates a controller backed by [repository].
  UsersListController(this._repository);

  final UserRepository _repository;
  final _state = Rx<UsersListState>(const UsersListInitial());

  /// Current list snapshot for UI binding.
  UsersListState get state => _state.value;

  /// Fetches a page of users and updates [state] with the result.
  Future<void> getUsers({int page = 1, int perPage = 10}) async {
    _state.value = const UsersListLoading();
    final result = await _repository.getUsers(page: page, perPage: perPage);
    _state.value = switch (result) {
      AppSuccess<PaginatedResponseModel<UserModel>>(:final data) => UsersListSuccess(data),
      AppFailure<PaginatedResponseModel<UserModel>>(:final error) => UsersListFailure(
          message: error.message,
          error: error.originalError,
        ),
    };
  }
}
