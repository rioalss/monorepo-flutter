/// Abstraction for non-sensitive local key-value persistence.
///
/// Suitable for preferences, caches, and other non-secret data.
/// Implementations typically wrap Hive or SharedPreferences.
library;

/// Contract for non-sensitive local key-value storage (e.g. Hive boxes).
abstract interface class ILocalStorage {
  /// Persists [value] under [key]. Overwrites any existing entry.
  Future<void> write<T>({required String key, required T value});

  /// Reads the value for [key], or null if absent or type mismatch.
  T? read<T>({required String key});

  /// Removes the entry for [key] if it exists.
  Future<void> delete({required String key});

  /// Removes all entries from this storage instance.
  Future<void> clear();

  /// Whether an entry exists for [key].
  bool containsKey({required String key});
}
