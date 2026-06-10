/// Centralized REST API path constants.
///
/// Endpoint values align with backend proto definitions and are matched by
/// interceptors via `String.contains` where noted.
library;

abstract final class Endpoints {
  /// Paths that skip the Authorization header (matched via `String.contains`).
  static const List<String> publicPaths = [
    signIn,
    signUp,
  ];

  // ==================== Auth Endpoints ====================

  /// Base path segment for authentication routes.
  static const String authBase = '/auth';

  /// POST /users/add (DummyJSON create user)
  static const String signUp = '/users/add';

  /// POST /user/login (DummyJSON login)
  static const String signIn = '/user/login';

  /// POST /v1/auth/refresh
  static const String refreshToken = '$authBase/refresh';

  // ==================== User Endpoints ====================

  /// Base path segment for user routes.
  static const String usersBase = '/users';

  /// GET /v1/users?page=&per_page=
  static const String listUsers = usersBase;

  /// GET /user/me (DummyJSON current user)
  static const String myProfile = '/user/me';

  /// PUT /v1/users/me
  static const String updateMyProfile = '$usersBase/me';

  /// GET /v1/users/{user_id}
  static String userProfile(String userId) => '$usersBase/$userId';
}
