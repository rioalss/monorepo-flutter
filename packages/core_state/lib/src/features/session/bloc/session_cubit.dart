/// BLoC cubit that tracks login session from [TokenStorage].
///
/// Listens to [SessionInvalidationHub] so network-driven token clears update
/// UI session state without a manual logout call.

library;

import 'package:core_state/src/features/session/session_invalidation_hub.dart';
import 'package:core_state/src/features/session/state/session_state.dart';
import 'package:core_storage/core_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Emits [SessionState] based on stored tokens and external invalidation events.
@lazySingleton
class SessionCubit extends Cubit<SessionState> {
  /// Registers [invalidate] on [invalidationHub] and starts in [SessionChecking].
  SessionCubit(this._tokenStorage, this._invalidationHub)
      : super(const SessionChecking()) {
    _invalidationHub.onInvalidated = invalidate;
  }

  final TokenStorage _tokenStorage;
  final SessionInvalidationHub _invalidationHub;

  /// Re-reads tokens and emits authenticated or unauthenticated state.
  Future<void> checkSession() async {
    emit(const SessionChecking());
    await _emitFromStorage();
  }

  /// Refreshes session state after a successful login writes new tokens.
  Future<void> onLoginSuccess() async {
    await _emitFromStorage();
  }

  /// Clears stored tokens and emits [SessionUnauthenticated].
  Future<void> logout() async {
    await _tokenStorage.clearTokens();
    emit(const SessionUnauthenticated());
  }

  /// Marks the session unauthenticated when tokens are cleared externally.
  ///
  /// No-op if already [SessionUnauthenticated].
  void invalidate() {
    if (state is SessionUnauthenticated) return;
    emit(const SessionUnauthenticated());
  }

  /// Reads [TokenStorage] and maps presence of tokens to session state.
  Future<void> _emitFromStorage() async {
    final loggedIn = await _tokenStorage.isLoggedIn();
    if (!loggedIn) {
      emit(const SessionUnauthenticated());
      return;
    }
    final userId = await _tokenStorage.getUserId();
    emit(SessionAuthenticated(userId: userId));
  }
}
