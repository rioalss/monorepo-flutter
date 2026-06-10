/// User repository implementation delegating to [UserService].
///
/// Maps single-user and paginated list responses to [AppResult], with custom
/// handling for paginated payloads that include metadata.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/core_network.dart';
import 'package:core_state/src/repositories/base_repository.dart';

/// Implements [UserRepository] using [UserService] for all network calls.
class UserRepositoryImpl extends BaseRepository implements UserRepository {
  /// Creates a repository backed by [service].
  UserRepositoryImpl({required UserService service}) : _service = service;

  final UserService _service;

  @override
  Future<AppResult<UserModel>> getUserById(String userId) =>
      execute(() => _service.getUserById(userId));

  @override
  Future<AppResult<PaginatedResponseModel<UserModel>>> getUsers({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _service.getUsers(page: page, perPage: perPage);
      final items = response.data;
      final meta = response.meta;
      if (items != null && meta != null) {
        return AppSuccess(PaginatedResponseModel(items: items, meta: meta));
      }
      return AppFailure(
        AppErrorModel(message: response.message ?? 'Empty response'),
      );
    } on Object catch (e) {
      return AppFailure(ExceptionMapper.map(e));
    }
  }
}
