/// Dio interceptor that attaches Bearer tokens and refreshes them on 401.
///
/// Queues concurrent requests while a refresh is in flight and clears the
/// session when refresh fails or the refresh endpoint itself returns 401.
library;

import 'dart:async';

import 'package:core_network/src/config/endpoints.dart';
import 'package:core_storage/core_storage.dart';
import 'package:dio/dio.dart';

/// Attaches Bearer tokens to requests and transparently refreshes them on 401.
///
/// When a 401 is received while a refresh is already in flight, subsequent
/// requests are queued and retried once the refresh resolves.
class AuthInterceptor extends Interceptor {
  /// Creates an interceptor bound to [dio] and [tokenStorage].
  ///
  /// [publicPaths] skip the Authorization header (matched via `contains`).
  /// [onSessionInvalidated] is called after tokens are cleared on auth failure.
  AuthInterceptor({
    required this.dio,
    required this.tokenStorage,
    this.publicPaths = const [],
    this.onSessionInvalidated,
  });

  /// Dio instance used for token refresh and request retries.
  final Dio dio;

  /// Persistent storage for access and refresh tokens.
  final TokenStorage tokenStorage;

  /// Optional callback invoked when the session is invalidated.
  final void Function()? onSessionInvalidated;

  /// Paths that bypass the Authorization header (matched via `contains`).
  final List<String> publicPaths;

  bool _isRefreshing = false;
  final List<Completer<bool>> _pendingRequests = [];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isPublicEndpoint(options.path)) return handler.next(options);
    final accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) return handler.next(err);

    const refreshPath = Endpoints.refreshToken;
    // if (refreshPath == null) return handler.next(err);

    // Never retry the refresh endpoint itself.
    if (err.requestOptions.path.contains(refreshPath)) {
      await _clearSession();
      return handler.next(err);
    }

    // Queue this request while another refresh is already in flight.
    if (_isRefreshing) {
      final completer = Completer<bool>();
      _pendingRequests.add(completer);
      final success = await completer.future;
      if (success) {
        return handler.resolve(await _retryRequest(err.requestOptions));
      }
      return handler.next(err);
    }

    _isRefreshing = true;
    try {
      final refreshed = await _refreshToken(refreshPath);
      _resolvePending(success: refreshed);
      if (refreshed) {
        return handler.resolve(await _retryRequest(err.requestOptions));
      }
      await _clearSession();
      return handler.next(err);
    } on Exception catch (_) {
      _resolvePending(success: false);
      await _clearSession();
      return handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  /// Completes all queued refresh waiters with [success].
  void _resolvePending({required bool success}) {
    for (final completer in _pendingRequests) {
      completer.complete(success);
    }
    _pendingRequests.clear();
  }

  /// Attempts to exchange the stored refresh token for new credentials.
  ///
  /// Returns `false` when no refresh token exists, the response is invalid,
  /// or the refresh request throws.
  Future<bool> _refreshToken(String refreshPath) async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await dio.post<dynamic>(
        refreshPath,
        data: {
          'refreshToken': refreshToken,
          'expiresInMins': 1,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          final newAccess =
              data['accessToken'] as String? ?? data['access_token'] as String?;
          final newRefresh = data['refreshToken'] as String? ??
              data['refresh_token'] as String?;
          if (newAccess != null && newRefresh != null) {
            await tokenStorage.saveTokens(
              accessToken: newAccess,
              refreshToken: newRefresh,
            );
            return true;
          }
        }
      }
      return false;
    } on Exception catch (_) {
      return false;
    }
  }

  /// Replays [options] with the latest access token in the Authorization header.
  Future<Response<dynamic>> _retryRequest(RequestOptions options) async {
    final accessToken = await tokenStorage.getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    return dio.request<dynamic>(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(
        method: options.method,
        headers: options.headers,
      ),
    );
  }

  /// Returns `true` when [path] matches any entry in [publicPaths].
  bool _isPublicEndpoint(String path) =>
      publicPaths.any((p) => path.contains(p));

  /// Clears stored tokens and notifies [onSessionInvalidated].
  Future<void> _clearSession() async {
    await tokenStorage.clearTokens();
    onSessionInvalidated?.call();
  }
}
