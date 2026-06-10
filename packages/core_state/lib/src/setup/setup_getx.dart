/// GetX + GetIt startup helper for injectable-based dependency injection.
///
/// Resets [ServiceLocator] and runs app-provided registration before
/// controllers are resolved from GetIt.

library;

import 'package:core_state/src/di/service_locator.dart';
import 'package:core_state/src/setup/state_management_setup.dart';

/// Initialises the GetX + GetIt + injectable setup.
///
/// Usage in `main.dart`:
/// ```dart
/// await dotenv.load(fileName: '.env');
/// await SetupGetX.init(
///   registerDependencies: () async {
///     registerExternalDependencies(
///       dioClient: dioClient,
///       listDioClient: listDioClient,
///       tokenStorage: TokenStorage(),
///       sessionInvalidationHub: sessionInvalidationHub,
///     );
///     await configureDependencies();
///   },
/// );
/// // UI: Get.put(getIt<LoginController>())
/// ```
class SetupGetX implements StateManagementSetup {
  /// Creates a const setup instance for use in `main`.
  const SetupGetX();

  @override
  Future<void> init({Future<void> Function()? registerDependencies}) async {
    await ServiceLocator.reset();
    await registerDependencies?.call();
  }
}
