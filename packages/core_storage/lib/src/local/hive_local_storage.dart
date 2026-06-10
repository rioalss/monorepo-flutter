/// Hive-backed local key-value storage for non-sensitive application data.
///
/// Provides [HiveLocalStorage], a concrete [ILocalStorage] implementation
/// that delegates to an open Hive [Box]. Boxes must be opened via
/// `HiveInitializer` before constructing storage instances.
library;

import 'package:core_domain/core_domain.dart';
import 'package:hive_ce/hive.dart';

/// Non-sensitive local key-value storage backed by a Hive [Box].
///
/// Prefer `HiveInitializer.initApp` for app bootstrap; use this constructor
/// only when wrapping a custom [Box].
///
/// Example:
/// ```dart
/// final localStorage = await HiveInitializer.initApp(
///   subDirectory: 'my_app',
/// );
/// ```
class HiveLocalStorage implements ILocalStorage {
  /// Creates storage backed by the given [box].
  ///
  /// The box must already be open; this class does not manage its lifecycle.
  HiveLocalStorage({required Box<dynamic> box}) : _box = box;

  final Box<dynamic> _box;

  /// Stores [value] under [key], replacing any existing entry.
  @override
  Future<void> write<T>({required String key, required T value}) =>
      _box.put(key, value);

  /// Returns the value for [key] cast to [T], or `null` when absent.
  ///
  /// Throws at runtime if the stored type does not match [T].
  @override
  T? read<T>({required String key}) => _box.get(key) as T?;

  /// Removes the entry for [key].
  @override
  Future<void> delete({required String key}) => _box.delete(key);

  /// Removes all entries from the underlying box.
  @override
  Future<void> clear() async => _box.clear();

  /// Whether [key] currently has a stored value.
  @override
  bool containsKey({required String key}) => _box.containsKey(key);
}
