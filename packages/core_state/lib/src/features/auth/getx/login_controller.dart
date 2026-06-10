/// GetX controller for username/password login.
///
/// Exposes reactive [LoginState] and delegates authentication to
/// [AuthRepository].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/auth/state/login_state.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// Reactive login manager for GetX apps.
@injectable
class LoginController extends GetxController {
  /// Creates a controller backed by [repository].
  LoginController(this._repository);

  final AuthRepository _repository;
  final _state = Rx<LoginState>(const LoginInitial());

  /// Current login snapshot for UI binding.
  LoginState get state => _state.value;

  /// Submits credentials and updates [state] with the result.
  Future<void> login({
    required String username,
    required String password,
    int expiresInMins = 30,
  }) async {
    _state.value = const LoginLoading();
    final result = await _repository.login(
      username: username,
      password: password,
      expiresInMins: expiresInMins,
    );
    _state.value = switch (result) {
      AppSuccess<AuthSessionModel>(:final data) => LoginSuccess(data),
      AppFailure<AuthSessionModel>(:final error) => LoginFailure(
          message: error.message,
          error: error.originalError,
        ),
    };
  }
}
