/// Application-level connectivity manager with cached state and broadcasts.
///
/// Wraps `NetworkInfo` for app-wide online/offline tracking. Call
/// `initialize` at startup and `dispose` when tearing down the service.
library;

import 'dart:async';

import 'package:core_domain/core_domain.dart';

/// Application-level connectivity manager.
///
/// Wraps [NetworkInfo] with a cached `isConnected` state and a broadcast stream.
/// Call [initialize] at app startup and [dispose] when the app is closed.
///
/// Example (in your DI setup):
/// ```dart
/// final service = ConnectivityService(networkInfo: NetworkInfoImpl());
/// await service.initialize();
/// ```
class ConnectivityService {
  /// Creates a service that mirrors connectivity from [networkInfo].
  ConnectivityService({required NetworkInfo networkInfo})
      : _networkInfo = networkInfo;

  final NetworkInfo _networkInfo;

  StreamSubscription<bool>? _subscription;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  bool _isConnected = true;

  /// Whether a real internet connection is currently available.
  ///
  /// Reflects the last known value from [initialize] or [onConnectivityChanged].
  bool get isConnected => _isConnected;

  /// Stream of connectivity changes.
  ///
  /// Emits `true` when connected and `false` when offline.
  Stream<bool> get onConnectivityChanged => _controller.stream;

  /// Starts listening to connectivity changes.
  ///
  /// Must be called before relying on [isConnected] or [onConnectivityChanged].
  Future<void> initialize() async {
    _isConnected = await _networkInfo.isConnected;
    _subscription = _networkInfo.onConnectivityChanged.listen((connected) {
      _isConnected = connected;
      _controller.add(connected);
    });
  }

  /// Performs an on-demand connectivity check, bypassing the cached value.
  Future<bool> checkConnectivity() => _networkInfo.isConnected;

  /// Executes [callback] immediately when online, or after reconnection.
  ///
  /// Throws [StateError] if [onConnectivityChanged] closes before connectivity
  /// is restored.
  Future<T> executeWhenConnected<T>(Future<T> Function() callback) async {
    if (_isConnected) return callback();
    await for (final connected in onConnectivityChanged) {
      if (connected) return callback();
    }
    throw StateError('Connectivity stream closed before connection was restored.');
  }

  /// Cancels the connectivity subscription and closes the broadcast stream.
  Future<void> dispose() async {
    await _subscription?.cancel();
    await _controller.close();
  }
}
