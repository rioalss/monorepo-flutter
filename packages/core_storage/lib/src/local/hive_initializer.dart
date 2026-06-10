// The singleton pattern for a platform-wrapper class is intentional here.
// ignore_for_file: prefer_constructors_over_static_methods

/// Hive initialisation and box lifecycle management.
///
/// Configures Hive with an app-specific directory under the documents folder
/// and exposes helpers to open, query, and close boxes used by
/// `HiveLocalStorage`.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_storage/src/local/hive_local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Manages the Hive lifecycle for the application.
///
/// Call [initApp] once at app startup before using [localStorage] or
/// opening additional boxes.
class HiveInitializer {
  HiveInitializer._();

  static HiveInitializer? _instance;

  /// Shared singleton for Hive bootstrap and default local storage.
  static HiveInitializer get instance => _instance ??= HiveInitializer._();

  static const settingsBoxName = 'settings';

  Box<dynamic>? _settingsBox;
  HiveLocalStorage? _localStorage;

  /// Whether [init] or [initApp] has completed successfully.
  bool get isInitialized => _settingsBox != null;

  /// One-shot bootstrap: `Hive.init`, open the settings box, return storage.
  static Future<ILocalStorage> initApp({
    required String subDirectory,
    String boxName = settingsBoxName,
  }) async {
    await instance.init(subDirectory: subDirectory, boxName: boxName);
    return instance.localStorage;
  }

  /// Initialises Hive in [subDirectory] and opens the default [boxName].
  ///
  /// Idempotent — safe to call more than once; subsequent calls are no-ops.
  Future<void> init({
    required String subDirectory,
    String boxName = settingsBoxName,
  }) async {
    if (isInitialized) return;

    final dir = await getApplicationDocumentsDirectory();
    Hive.init(path.join(dir.path, subDirectory));
    _settingsBox = await Hive.openBox<dynamic>(boxName);
    _localStorage = HiveLocalStorage(box: _settingsBox!);
  }

  /// Default non-sensitive storage backed by the settings box.
  ///
  /// Throws [StateError] when [initApp] has not been called yet.
  ILocalStorage get localStorage {
    final storage = _localStorage;
    if (storage == null) {
      throw StateError('Call HiveInitializer.initApp() first.');
    }
    return storage;
  }

  /// Opens (or returns an already-open) Hive box with [name].
  ///
  /// Requires [init] to have completed first.
  Future<Box<T>> openBox<T>(String name) {
    if (!isInitialized) {
      throw StateError('Call HiveInitializer.initApp() before openBox().');
    }
    return Hive.openBox<T>(name);
  }

  /// Closes all open Hive boxes and releases resources.
  ///
  /// Any subsequent reads or writes require calling [initApp] again.
  Future<void> closeAll() async {
    await Hive.close();
    _settingsBox = null;
    _localStorage = null;
  }

  /// Whether the box with [name] is currently open in memory.
  bool isBoxOpen(String name) => Hive.isBoxOpen(name);

  /// Clears the singleton for unit tests.
  @visibleForTesting
  static void reset() {
    _instance = null;
  }
}
