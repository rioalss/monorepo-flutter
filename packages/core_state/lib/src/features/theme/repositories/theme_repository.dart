/// Theme preference persistence contract and in-memory default implementation.
///
/// Abstracts read/write of [ThemeMode] so cubits and notifiers stay storage-
/// agnostic.

library;

import 'package:flutter/material.dart';

/// Persists the user's [ThemeMode] preference.
abstract interface class ThemeRepository {
  /// Returns the last saved theme mode, or a sensible default.
  Future<ThemeMode> read();

  /// Persists [mode] for subsequent [read] calls.
  Future<void> save(ThemeMode mode);
}

/// In-memory implementation for apps without local storage wired yet.
final class InMemoryThemeRepository implements ThemeRepository {
  ThemeMode _mode = ThemeMode.system;

  @override
  Future<ThemeMode> read() async => _mode;

  @override
  Future<void> save(ThemeMode mode) async {
    _mode = mode;
  }
}
