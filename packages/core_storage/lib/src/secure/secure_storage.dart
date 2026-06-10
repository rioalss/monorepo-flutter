// The singleton pattern for a platform-wrapper class is intentional here.
// ignore_for_file: prefer_constructors_over_static_methods

/// Platform secure key-value storage for sensitive application data.
///
/// Wraps `flutter_secure_storage` and implements [ISecureStorage] from
/// `core_domain`. Values are stored in the OS keychain (iOS) or encrypted
/// shared preferences (Android).
library;

import 'package:core_domain/core_domain.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure key-value storage backed by `flutter_secure_storage`.
///
/// On iOS, items use `first_unlock_this_device` accessibility so they remain
/// unavailable until the device has been unlocked once after boot.
class SecureStorage implements ISecureStorage {
  SecureStorage._();

  static SecureStorage? _instance;

  /// Shared singleton. Prefer injecting [ISecureStorage] in production code.
  static SecureStorage get instance => _instance ??= SecureStorage._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// Persists [value] under [key], overwriting any existing entry.
  @override
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  /// Returns the stored value for [key], or `null` when absent.
  @override
  Future<String?> read({required String key}) => _storage.read(key: key);

  /// Removes the entry for [key]. No-op when the key does not exist.
  @override
  Future<void> delete({required String key}) => _storage.delete(key: key);

  /// Removes every key-value pair from secure storage.
  @override
  Future<void> deleteAll() => _storage.deleteAll();

  /// Whether [key] currently has a stored value.
  @override
  Future<bool> containsKey({required String key}) =>
      _storage.containsKey(key: key);

  /// Returns all stored entries as a map of string keys to string values.
  @override
  Future<Map<String, String>> readAll() => _storage.readAll();
}
