/// BLoC that handles username/password login via [AuthRepository].
///
/// Maps [LoginSubmitted] events to [LoginState] loading, success, and failure
/// emissions.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/auth/bloc/login_event.dart';
import 'package:core_state/src/features/auth/state/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Coordinates login submissions and emits [LoginState] updates.
@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Registers the [LoginSubmitted] handler and starts in [LoginInitial].
  LoginBloc(this._repository) : super(const LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _repository;

  /// Calls [AuthRepository.login] and maps the [AppResult] to [LoginState].
  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    final result = await _repository.login(
      username: event.username,
      password: event.password,
      expiresInMins: event.expiresInMins,
    );
    switch (result) {
      case AppSuccess<AuthSessionModel>(:final data):
        emit(LoginSuccess(data));
      case AppFailure<AuthSessionModel>(:final error):
        emit(
          LoginFailure(
            message: error.message,
            error: error.originalError,
          ),
        );
    }
  }
}
