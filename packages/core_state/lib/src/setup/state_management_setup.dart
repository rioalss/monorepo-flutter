/// Contract for framework-specific app startup initialization.
///
/// Each implementation resets or prepares DI and must be awaited before
/// `runApp`.

library;

abstract interface class StateManagementSetup {
  /// Bootstraps DI and optional app-provided dependency registration.
  ///
  /// [registerDependencies] is invoked when the host app must register
  /// clients, storage, or other externals before feature modules resolve.
  Future<void> init({Future<void> Function()? registerDependencies});
}
