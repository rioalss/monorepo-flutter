/// BLoC that fetches paginated users via [UserRepository].
///
/// Maps [UsersListRequested] events to [UsersListState] loading, success, and
/// failure emissions.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/user/bloc/users_list_event.dart';
import 'package:core_state/src/features/user/state/users_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Coordinates paginated user list fetches and emits [UsersListState] updates.
@injectable
class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  /// Registers the [UsersListRequested] handler and starts in [UsersListInitial].
  UsersListBloc(this._repository) : super(const UsersListInitial()) {
    on<UsersListRequested>(_onRequested);
  }

  final UserRepository _repository;

  /// Calls [UserRepository.getUsers] and maps the [AppResult] to [UsersListState].
  Future<void> _onRequested(
    UsersListRequested event,
    Emitter<UsersListState> emit,
  ) async {
    emit(const UsersListLoading());
    final result = await _repository.getUsers(
      page: event.page,
      perPage: event.perPage,
    );
    switch (result) {
      case AppSuccess<PaginatedResponseModel<UserModel>>(:final data):
        emit(UsersListSuccess(data));
      case AppFailure<PaginatedResponseModel<UserModel>>(:final error):
        emit(
          UsersListFailure(
            message: error.message,
            error: error.originalError,
          ),
        );
    }
  }
}
