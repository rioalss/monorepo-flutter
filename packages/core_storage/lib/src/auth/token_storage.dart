/// Secure persistence for OAuth and session tokens.
///
/// Wraps [ISecureStorage] with typed accessors for access, refresh, and ID
/// tokens plus expiry metadata. Used by authentication flows to persist and
/// evaluate login state across app restarts.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_storage/src/secure/secure_storage.dart';

/// Typed token storage backed by [ISecureStorage].
///
/// Optional fields (ID token, expiry, user ID) are written only when provided
/// to [saveTokens] and are not cleared unless [clearTokens] is called.
class TokenStorage {
  /// Creates storage using [secureStorage], defaulting to [SecureStorage.instance].
  TokenStorage({ISecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? SecureStorage.instance;

  final ISecureStorage _secureStorage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _idTokenKey = 'id_token';
  static const String _tokenExpiryKey = 'token_expiry';
  static const String _userIdKey = 'user_id';

  /// Persists authentication tokens and optional metadata.
  ///
  /// [idToken], [expiryTime], and [userId] are stored only when non-null;
  /// previously saved optional values are left unchanged when omitted.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? idToken,
    DateTime? expiryTime,
    String? userId,
  }) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    if (idToken != null) {
      await _secureStorage.write(key: _idTokenKey, value: idToken);
    }
    if (expiryTime != null) {
      await _secureStorage.write(
        key: _tokenExpiryKey,
        value: expiryTime.toIso8601String(),
      );
    }
    if (userId != null) {
      await _secureStorage.write(key: _userIdKey, value: userId);
    }
  }

  /// Returns the stored access token, or `null` when not logged in.
  Future<String?> getAccessToken() =>
      _secureStorage.read(key: _accessTokenKey);

  /// Returns the stored refresh token, or `null` when absent.
  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: _refreshTokenKey);

  /// Returns the stored OpenID ID token, or `null` when not saved.
  Future<String?> getIdToken() => _secureStorage.read(key: _idTokenKey);

  /// Returns the parsed token expiry, or `null` when no expiry was stored.
  ///
  /// Returns `null` when the stored ISO-8601 string cannot be parsed.
  Future<DateTime?> getTokenExpiry() async {
    final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryString == null) return null;
    return DateTime.tryParse(expiryString);
  }

  /// Returns the stored user identifier, or `null` when not saved.
  Future<String?> getUserId() => _secureStorage.read(key: _userIdKey);

  /// Whether the access token has passed its stored expiry.
  ///
  /// Returns `true` when no expiry is recorded, treating missing expiry as
  /// expired.
  Future<bool> isTokenExpired() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  /// Whether the user has a valid session or can refresh credentials.
  ///
  /// Returns `true` when an access token exists and is not expired, or when
  /// the access token is expired but a refresh token is still available.
  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) return false;
    final expired = await isTokenExpired();
    if (expired) {
      final refreshToken = await getRefreshToken();
      return refreshToken != null;
    }
    return true;
  }

  /// Replaces the access token and optionally updates the expiry timestamp.
  ///
  /// Does not modify the refresh token or other stored metadata.
  Future<void> updateAccessToken(
    String accessToken, {
    DateTime? expiryTime,
  }) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    if (expiryTime != null) {
      await _secureStorage.write(
        key: _tokenExpiryKey,
        value: expiryTime.toIso8601String(),
      );
    }
  }

  /// Removes all stored tokens and associated metadata.
  Future<void> clearTokens() => Future.wait([
        _secureStorage.delete(key: _accessTokenKey),
        _secureStorage.delete(key: _refreshTokenKey),
        _secureStorage.delete(key: _idTokenKey),
        _secureStorage.delete(key: _tokenExpiryKey),
        _secureStorage.delete(key: _userIdKey),
      ]);
}
