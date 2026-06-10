/// Hive-backed [ThemeRepository] using [ILocalStorage].
///
/// Serializes [ThemeMode] to string values under the `theme_mode` key.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/theme/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

/// Persists theme preference via non-sensitive local key-value storage.
final class ThemeRepositoryImpl implements ThemeRepository {
  /// Creates a repository backed by [localStorage].
  ThemeRepositoryImpl({required ILocalStorage localStorage})
      : _localStorage = localStorage;

  final ILocalStorage _localStorage;

  static const _key = 'theme_mode';

  @override
  Future<ThemeMode> read() async {
    final raw = _localStorage.read<String>(key: _key);
    return _decode(raw) ?? ThemeMode.system;
  }

  @override
  Future<void> save(ThemeMode mode) async {
    await _localStorage.write(key: _key, value: _encode(mode));
  }

  static String _encode(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };

  static ThemeMode? _decode(String? raw) => switch (raw) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => null,
      };
}
