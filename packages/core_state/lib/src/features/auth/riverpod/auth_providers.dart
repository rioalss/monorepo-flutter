/// Riverpod providers for login and registration notifiers.
///
/// Re-exports auth repository providers and exposes [loginProvider] and
/// [registerProvider] for UI consumption.

library;

import 'package:core_state/src/features/auth/riverpod/login_notifier.dart';
import 'package:core_state/src/features/auth/riverpod/register_notifier.dart';
import 'package:core_state/src/features/auth/state/login_state.dart';
import 'package:core_state/src/features/auth/state/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:core_state/src/features/auth/riverpod/auth_repository_providers.dart';

/// Global login state provider for Riverpod apps.
final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);

/// Global registration state provider for Riverpod apps.
final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  RegisterNotifier.new,
);
