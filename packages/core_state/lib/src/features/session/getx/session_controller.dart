/// GetX controller that tracks login session from [TokenStorage].
///
/// Mirrors [SessionCubit] for apps using GetX reactive state instead of BLoC.

library;

import 'package:core_state/src/features/session/session_invalidation_hub.dart';
import 'package:core_state/src/features/session/state/session_state.dart';
import 'package:core_storage/core_storage.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// Reactive session manager backed by [TokenStorage].
@lazySingleton
class SessionController extends GetxController {
  /// Registers [invalidate] on [invalidationHub] and starts in [SessionChecking].
  SessionController(this._tokenStorage, this._invalidationHub) {
    _invalidationHub.onInvalidated = invalidate;
  }

  final TokenStorage _tokenStorage;
  final SessionInvalidationHub _invalidationHub;
  final _state = Rx<SessionState>(const SessionChecking());

  /// Current session snapshot for UI binding.
  SessionState get state => _state.value;

  /// Re-reads tokens and updates [state].
  Future<void> checkSession() async {
    _state.value = const SessionChecking();
    await _emitFromStorage();
  }

  /// Refreshes session state after a successful login writes new tokens.
  Future<void> onLoginSuccess() async {
    await _emitFromStorage();
  }

  /// Clears stored tokens and sets [SessionUnauthenticated].
  Future<void> logout() async {
    await _tokenStorage.clearTokens();
    _state.value = const SessionUnauthenticated();
  }

  /// Marks the session unauthenticated when tokens are cleared externally.
  ///
  /// No-op if already [SessionUnauthenticated].
  void invalidate() {
    if (_state.value is SessionUnauthenticated) return;
    _state.value = const SessionUnauthenticated();
  }

  /// Reads [TokenStorage] and maps presence of tokens to [state].
  Future<void> _emitFromStorage() async {
    final loggedIn = await _tokenStorage.isLoggedIn();
    if (!loggedIn) {
      _state.value = const SessionUnauthenticated();
      return;
    }
    final userId = await _tokenStorage.getUserId();
    _state.value = SessionAuthenticated(userId: userId);
  }
}
