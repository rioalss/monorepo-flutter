/// Registers app-owned runtime dependencies before injectable initialization.
///
/// These types cannot be constructed inside `core_state` because they require
/// environment-specific configuration from the host application.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/core_network.dart';
import 'package:core_state/src/di/injection.dart';
import 'package:core_state/src/features/session/session_invalidation_hub.dart';
import 'package:core_storage/core_storage.dart';

/// Registers runtime dependencies that must be provided by the app
/// before calling [configureDependencies].
///
/// Call this inside `SetupBloc.init` / `SetupGetX.init` `registerDependencies`.
void registerExternalDependencies({
  required DioClient dioClient,
  required DioClient listDioClient,
  required TokenStorage tokenStorage,
  required SessionInvalidationHub sessionInvalidationHub,
  required ILocalStorage localStorage,
}) {
  getIt
    ..registerSingleton<DioClient>(dioClient)
    ..registerSingleton<DioClient>(listDioClient, instanceName: 'list')
    ..registerSingleton<TokenStorage>(tokenStorage)
    ..registerSingleton<SessionInvalidationHub>(sessionInvalidationHub)
    ..registerSingleton<ILocalStorage>(localStorage);
}
