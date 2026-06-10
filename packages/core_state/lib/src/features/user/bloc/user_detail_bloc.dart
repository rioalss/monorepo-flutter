/// BLoC that fetches a single user profile via [UserRepository].
///
/// Maps [UserDetailRequested] events to [UserDetailState] loading, success, and
/// failure emissions.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/user/bloc/user_detail_event.dart';
import 'package:core_state/src/features/user/state/user_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Coordinates single-user fetches and emits [UserDetailState] updates.
@injectable
class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  /// Registers the [UserDetailRequested] handler and starts in [UserDetailInitial].
  UserDetailBloc(this._repository) : super(const UserDetailInitial()) {
    on<UserDetailRequested>(_onRequested);
  }

  final UserRepository _repository;

  /// Calls [UserRepository.getUserById] and maps the [AppResult] to [UserDetailState].
  Future<void> _onRequested(
    UserDetailRequested event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(const UserDetailLoading());
    final result = await _repository.getUserById(event.userId);
    switch (result) {
      case AppSuccess<UserModel>(:final data):
        emit(UserDetailSuccess(data));
      case AppFailure<UserModel>(:final error):
        emit(
          UserDetailFailure(
            message: error.message,
            error: error.originalError,
          ),
        );
    }
  }
}
