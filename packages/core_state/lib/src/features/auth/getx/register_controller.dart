/// GetX controller for user registration.
///
/// Exposes reactive [RegisterState] and delegates account creation to
/// [AuthRepository].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/auth/state/register_state.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// Reactive registration manager for GetX apps.
@injectable
class RegisterController extends GetxController {
  /// Creates a controller backed by [repository].
  RegisterController(this._repository);

  final AuthRepository _repository;
  final _state = Rx<RegisterState>(const RegisterInitial());

  /// Current registration snapshot for UI binding.
  RegisterState get state => _state.value;

  /// Submits profile data and updates [state] with the result.
  Future<void> register({
    required String firstName,
    required String lastName,
    required int age,
  }) async {
    _state.value = const RegisterLoading();
    final result = await _repository.register(
      firstName: firstName,
      lastName: lastName,
      age: age,
    );
    _state.value = switch (result) {
      AppSuccess<UserModel>(:final data) => RegisterSuccess(data),
      AppFailure<UserModel>(:final error) => RegisterFailure(
          message: error.message,
          error: error.originalError,
        ),
    };
  }
}
