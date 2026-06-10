/// HTTP service for user-related API endpoints.
///
/// Paginated list requests use a separate `DioClient` configured with
/// `API_LIST_BASE_URL`; all other calls use the default authenticated client.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/src/client/dio_client.dart';
import 'package:core_network/src/config/endpoints.dart';
import 'package:core_network/src/service/base_api_service.dart';

/// Service for user profile and listing endpoints.
///
/// `listClient` targets the list API base URL for paginated user queries.
/// All other endpoints use the primary client from `BaseApiService`.
class UserService extends BaseApiService {
  /// Creates a service with [client] for standard endpoints and [listClient]
  /// for paginated list requests.
  UserService({
    required super.client,
    required DioClient listClient,
  }) : _listClient = listClient;

  final DioClient _listClient;

  /// Fetches a single user by [userId].
  ///
  /// Returns a parsed [UserModel] wrapped in [ApiResponseModel].
  Future<ApiResponseModel<UserModel>> getUserById(String userId) => get(
        Endpoints.userProfile(userId),
        fromJson: (json) => UserModel.fromJson(json! as Map<String, dynamic>),
      );

  /// Fetches a paginated list of users.
  ///
  /// [page] is 1-based; [perPage] controls the `limit` query parameter.
  /// Returns an empty list when the response body cannot be parsed as a map.
  Future<ApiResponseModel<List<UserModel>>> getUsers({
    int page = 1,
    int perPage = 10,
  }) async {
    final skip = (page - 1) * perPage;
    final raw = await _listClient.get(
      Endpoints.listUsers,
      queryParameters: {
        'skip': skip,
        'limit': perPage,
      },
    );

    if (raw is! Map<String, dynamic>) {
      return const ApiResponseModel(message: 'Failed to parse users list');
    }

    final usersJson = raw['users'];
    final users = usersJson is List
        ? usersJson
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : <UserModel>[];

    final total = safeParseIntOrDefault(raw['total']);
    final responseSkip = safeParseIntOrDefault(raw['skip'], skip);
    final limit = safeParseIntOrDefault(raw['limit'], perPage);

    return ApiResponseModel(
      success: true,
      data: users,
      meta: PaginatedMetaModel.fromDummyJson(
        total: total,
        skip: responseSkip,
        limit: limit,
      ),
    );
  }
}
