/// Abstraction for checking real internet reachability.
///
/// Wraps `InternetConnection` to verify actual network access rather than
/// relying solely on local Wi-Fi or mobile interface state.
library;

import 'package:core_domain/core_domain.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Default [NetworkInfo] implementation backed by [InternetConnection].
///
/// Uses active reachability checks instead of platform connectivity flags alone.
class NetworkInfoImpl implements NetworkInfo {
  /// Creates an implementation, optionally injecting a custom [connection].
  NetworkInfoImpl({InternetConnection? connection})
      : _connection = connection ?? InternetConnection();

  final InternetConnection _connection;

  @override
  Future<bool> get isConnected => _connection.hasInternetAccess;

  @override
  Stream<bool> get onConnectivityChanged => _connection.onStatusChange.map(
        (status) => status == InternetStatus.connected,
      );
}

/// Shared default instance used by `DioClientFactory` and optional UI wiring.
final NetworkInfo defaultNetworkInfo = NetworkInfoImpl();
