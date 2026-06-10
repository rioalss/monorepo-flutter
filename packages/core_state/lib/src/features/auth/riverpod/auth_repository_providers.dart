/// Riverpod providers for auth services and [AuthRepository].
///
/// Composes infrastructure clients with [AuthRepositoryImpl] for feature
/// notifiers.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/core_network.dart';
import 'package:core_state/src/di/riverpod/infrastructure_providers.dart';
import 'package:core_state/src/features/auth/repositories/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// API client for authentication endpoints.
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(client: ref.watch(dioClientProvider)),
);

/// Domain repository that persists tokens on successful login.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    service: ref.watch(authServiceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
  ),
);
