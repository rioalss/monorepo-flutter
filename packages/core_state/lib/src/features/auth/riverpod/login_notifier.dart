/// Riverpod notifier for username/password login.
///
/// Manages [LoginState] and delegates authentication to [authRepositoryProvider].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/auth/riverpod/auth_repository_providers.dart';
import 'package:core_state/src/features/auth/state/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles login submissions for Riverpod consumers.
class LoginNotifier extends Notifier<LoginState> {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  LoginState build() => const LoginInitial();

  /// Submits credentials and updates [state] with the result.
  Future<void> login({
    required String username,
    required String password,
    int expiresInMins = 30,
  }) async {
    state = const LoginLoading();
    final result = await _repository.login(
      username: username,
      password: password,
      expiresInMins: expiresInMins,
    );
    state = switch (result) {
      AppSuccess<AuthSessionModel>(:final data) => LoginSuccess(data),
      AppFailure<AuthSessionModel>(:final error) => LoginFailure(
          message: error.message,
          error: error.originalError,
        ),
    };
  }
}
