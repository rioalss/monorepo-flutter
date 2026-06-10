/// Riverpod providers for user services and [UserRepository].
///
/// Composes primary and list-scoped Dio clients with [UserRepositoryImpl].

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/core_network.dart';
import 'package:core_state/src/di/riverpod/infrastructure_providers.dart';
import 'package:core_state/src/features/user/repositories/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// API client for user endpoints, including paginated list requests.
final userServiceProvider = Provider<UserService>(
  (ref) => UserService(
    client: ref.watch(dioClientProvider),
    listClient: ref.watch(listDioClientProvider),
  ),
);

/// Domain repository for single-user and paginated list operations.
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(service: ref.watch(userServiceProvider)),
);
