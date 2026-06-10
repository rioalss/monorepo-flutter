/// Riverpod providers for shared infrastructure (network, storage, session hub).
///
/// [dioClientProvider] reads API config from dotenv; load env vars before the
/// first provider read.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/core_network.dart';
import 'package:core_state/src/features/session/session_invalidation_hub.dart';
import 'package:core_storage/core_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Local token persistence used by Dio clients and session notifiers.
final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

/// Non-sensitive local key-value storage for preferences such as theme mode.
///
/// Must be overridden after Hive initialization in the host app.
final localStorageProvider = Provider<ILocalStorage>(
  (ref) => throw StateError(
    'Override localStorageProvider after Hive initialization.',
  ),
);

/// Connectivity helper shared across repositories that need offline checks.
final networkInfoProvider = Provider<NetworkInfo>((ref) => defaultNetworkInfo);

/// Hub that propagates auth interceptor session clears to UI session state.
final sessionInvalidationHubProvider = Provider<SessionInvalidationHub>(
  (ref) => SessionInvalidationHub(),
);

/// Primary API [DioClient] with token injection and session invalidation callback.
final dioClientProvider = Provider<DioClient>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final invalidationHub = ref.watch(sessionInvalidationHubProvider);
  return const DioClientFactory().create(
    config: ApiConfig.defaultConfig(),
    tokenStorage: tokenStorage,
    onSessionInvalidated: invalidationHub.notify,
  );
});

/// List-endpoint [DioClient] using separate base URL configuration.
final listDioClientProvider = Provider<DioClient>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final invalidationHub = ref.watch(sessionInvalidationHubProvider);
  return const DioClientFactory().create(
    config: ApiConfig.listConfig(),
    tokenStorage: tokenStorage,
    onSessionInvalidated: invalidationHub.notify,
  );
});
