/// HTTP service for authentication endpoints.
///
/// Exposes login and registration calls built on `BaseApiService` response
/// parsing and the shared authenticated `DioClient`.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/src/config/endpoints.dart';
import 'package:core_network/src/service/base_api_service.dart';

/// Service for sign-in and sign-up API endpoints.
class AuthService extends BaseApiService {
  /// Creates a service backed by the given authenticated [client].
  AuthService({required super.client});

  /// Authenticates with [username] and [password].
  ///
  /// [expiresInMins] controls the requested session lifetime on the server.
  /// Returns an [AuthSessionModel] on success.
  Future<ApiResponseModel<AuthSessionModel>> login({
    required String username,
    required String password,
    int expiresInMins = 30,
  }) =>
      post(
        Endpoints.signIn,
        data: {
          'username': username,
          'password': password,
          'expiresInMins': expiresInMins,
        },
        fromJson: (json) =>
            AuthSessionModel.fromJson(json! as Map<String, dynamic>),
      );

  /// Registers a new user with the given profile fields.
  ///
  /// Returns the created [UserModel] wrapped in [ApiResponseModel].
  Future<ApiResponseModel<UserModel>> register({
    required String firstName,
    required String lastName,
    required int age,
  }) =>
      post(
        Endpoints.signUp,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'age': age,
        },
        fromJson: (json) => UserModel.fromJson(json! as Map<String, dynamic>),
      );
}
