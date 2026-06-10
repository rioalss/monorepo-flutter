/// Riverpod notifier for user registration.
///
/// Manages [RegisterState] and delegates account creation to
/// [authRepositoryProvider].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/auth/riverpod/auth_repository_providers.dart';
import 'package:core_state/src/features/auth/state/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles registration submissions for Riverpod consumers.
class RegisterNotifier extends Notifier<RegisterState> {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  RegisterState build() => const RegisterInitial();

  /// Submits profile data and updates [state] with the result.
  Future<void> register({
    required String firstName,
    required String lastName,
    required int age,
  }) async {
    state = const RegisterLoading();
    final result = await _repository.register(
      firstName: firstName,
      lastName: lastName,
      age: age,
    );
    state = switch (result) {
      AppSuccess<UserModel>(:final data) => RegisterSuccess(data),
      AppFailure<UserModel>(:final error) => RegisterFailure(
          message: error.message,
          error: error.originalError,
        ),
    };
  }
}
