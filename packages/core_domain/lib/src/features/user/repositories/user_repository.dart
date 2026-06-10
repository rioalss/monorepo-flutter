/// User repository contract for fetching profile and list data.
///
/// Defines read operations for user entities. Implementations in `core_state`
/// handle networking and map responses to [AppResult] values.
library;

import 'package:core_domain/src/features/user/models/user_model.dart';
import 'package:core_domain/src/models/response/paginated_response_model.dart';
import 'package:core_domain/src/models/result/app_result.dart';

/// Contract for retrieving single users and paginated user lists.
abstract interface class UserRepository {
  /// Fetches a user by [userId].
  ///
  /// Returns [AppSuccess] with [UserModel] or [AppFailure] if not found or on error.
  Future<AppResult<UserModel>> getUserById(String userId);

  /// Fetches a paginated list of users.
  ///
  /// [page] is 1-based. [perPage] controls page size.
  /// Returns [AppSuccess] with items and pagination meta, or [AppFailure] on error.
  Future<AppResult<PaginatedResponseModel<UserModel>>> getUsers({
    int page = 1,
    int perPage = 10,
  });
}
