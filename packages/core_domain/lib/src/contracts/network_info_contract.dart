/// Abstraction for observing device network connectivity.
///
/// Implemented in infrastructure layers (e.g. connectivity_plus wrapper).
/// Used by repositories to gate offline-sensitive operations.
library;

/// Contract for checking real internet connectivity.
abstract interface class NetworkInfo {
  /// Whether the device currently has a usable network connection.
  Future<bool> get isConnected;

  /// Stream that emits connectivity changes as they occur.
  Stream<bool> get onConnectivityChanged;
}
