/// Riverpod notifier that tracks login session from [TokenStorage].
///
/// Wires [SessionInvalidationHub] during [build] so interceptor clears update
/// provider state.

library;

import 'package:core_state/src/di/riverpod/infrastructure_providers.dart';
import 'package:core_state/src/features/session/state/session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Manages [SessionState] for Riverpod consumers.
class SessionNotifier extends Notifier<SessionState> {
  @override
  SessionState build() {
    ref.read(sessionInvalidationHubProvider).onInvalidated = invalidate;
    return const SessionChecking();
  }

  /// Re-reads tokens and updates [state].
  Future<void> checkSession() async {
    state = const SessionChecking();
    await _emitFromStorage();
  }

  /// Refreshes session state after a successful login writes new tokens.
  Future<void> onLoginSuccess() async {
    await _emitFromStorage();
  }

  /// Clears stored tokens and sets [SessionUnauthenticated].
  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearTokens();
    state = const SessionUnauthenticated();
  }

  /// Marks the session unauthenticated when tokens are cleared externally.
  ///
  /// No-op if already [SessionUnauthenticated].
  void invalidate() {
    if (state is SessionUnauthenticated) return;
    state = const SessionUnauthenticated();
  }

  /// Reads [tokenStorageProvider] and maps token presence to [state].
  Future<void> _emitFromStorage() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final loggedIn = await tokenStorage.isLoggedIn();
    if (!loggedIn) {
      state = const SessionUnauthenticated();
      return;
    }
    final userId = await tokenStorage.getUserId();
    state = SessionAuthenticated(userId: userId);
  }
}
