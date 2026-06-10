/// Authentication repository contract for login and registration flows.
///
/// Defines domain-level auth operations. Concrete implementations live in
/// `core_state` and map API responses to [AppResult] values.
library;

import 'package:core_domain/src/features/auth/models/auth_session_model.dart';
import 'package:core_domain/src/features/user/models/user_model.dart';
import 'package:core_domain/src/models/result/app_result.dart';

/// Contract for authenticating users and creating new accounts.
abstract interface class AuthRepository {
  /// Signs in with [username] and [password].
  ///
  /// [expiresInMins] controls session lifetime when supported by the backend.
  /// Returns [AppSuccess] with [AuthSessionModel] or [AppFailure] on error.
  Future<AppResult<AuthSessionModel>> login({
    required String username,
    required String password,
    int expiresInMins = 30,
  });

  /// Registers a new user with the given profile fields.
  ///
  /// Returns [AppSuccess] with the created [UserModel] or [AppFailure] on error.
  Future<AppResult<UserModel>> register({
    required String firstName,
    required String lastName,
    required int age,
  });
}
