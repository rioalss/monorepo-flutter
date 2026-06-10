/// BLoC that handles user registration via [AuthRepository].
///
/// Maps [RegisterSubmitted] events to [RegisterState] loading, success, and
/// failure emissions.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/auth/bloc/register_event.dart';
import 'package:core_state/src/features/auth/state/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Coordinates registration submissions and emits [RegisterState] updates.
@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  /// Registers the [RegisterSubmitted] handler and starts in [RegisterInitial].
  RegisterBloc(this._repository) : super(const RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
  }

  final AuthRepository _repository;

  /// Calls [AuthRepository.register] and maps the [AppResult] to [RegisterState].
  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterLoading());
    final result = await _repository.register(
      firstName: event.firstName,
      lastName: event.lastName,
      age: event.age,
    );
    switch (result) {
      case AppSuccess<UserModel>(:final data):
        emit(RegisterSuccess(data));
      case AppFailure<UserModel>(:final error):
        emit(
          RegisterFailure(
            message: error.message,
            error: error.originalError,
          ),
        );
    }
  }
}
