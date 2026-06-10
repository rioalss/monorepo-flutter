/// Riverpod provider exposing [SessionNotifier] and [SessionState].
///
/// Watch [sessionProvider] for auth gating; call notifier methods for
/// check, logout, and post-login refresh.

library;

import 'package:core_state/src/features/session/riverpod/session_notifier.dart';
import 'package:core_state/src/features/session/state/session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Global session state provider for Riverpod apps.
final sessionProvider = NotifierProvider<SessionNotifier, SessionState>(
  SessionNotifier.new,
);
