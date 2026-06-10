/// Abstraction for encrypted storage of sensitive strings.
///
/// Used for auth tokens, credentials, and other secrets.
/// Implementations typically wrap flutter_secure_storage.
library;

/// Contract for secure key-value storage of sensitive data such as tokens.
abstract interface class ISecureStorage {
  /// Writes [value] under [key], replacing any existing value.
  Future<void> write({required String key, required String value});

  /// Reads the string for [key], or null if not found.
  Future<String?> read({required String key});

  /// Deletes the entry for [key] if it exists.
  Future<void> delete({required String key});

  /// Deletes all stored entries.
  Future<void> deleteAll();

  /// Whether an entry exists for [key].
  Future<bool> containsKey({required String key});

  /// Returns all key-value pairs currently stored.
  Future<Map<String, String>> readAll();
}
