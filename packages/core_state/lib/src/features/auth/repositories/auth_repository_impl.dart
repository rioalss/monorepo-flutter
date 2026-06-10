/// Auth repository implementation with token persistence on login.
///
/// Delegates network calls to [AuthService] and saves session tokens via
/// [TokenStorage] after a successful login response.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/core_network.dart';
import 'package:core_state/src/repositories/base_repository.dart';
import 'package:core_storage/core_storage.dart';

/// Implements [AuthRepository] using [AuthService] for network calls and
/// [TokenStorage] to persist session tokens after a successful login.
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  /// Creates a repository with the given service and token storage.
  AuthRepositoryImpl({
    required AuthService service,
    required TokenStorage tokenStorage,
  })  : _service = service,
        _tokenStorage = tokenStorage;

  final AuthService _service;
  final TokenStorage _tokenStorage;

  @override
  Future<AppResult<AuthSessionModel>> login({
    required String username,
    required String password,
    int expiresInMins = 30,
  }) async {
    final result = await execute(
      () => _service.login(
        username: username,
        password: password,
        expiresInMins: expiresInMins,
      ),
    );
    if (result case AppSuccess(:final data)) {
      await _tokenStorage.saveTokens(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
        userId: data.userId,
      );
    }
    return result;
  }

  @override
  Future<AppResult<UserModel>> register({
    required String firstName,
    required String lastName,
    required int age,
  }) =>
      execute(
        () => _service.register(
          firstName: firstName,
          lastName: lastName,
          age: age,
        ),
      );
}
