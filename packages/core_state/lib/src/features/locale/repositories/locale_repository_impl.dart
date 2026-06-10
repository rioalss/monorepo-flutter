/// Hive-backed [LocaleRepository] using [ILocalStorage].
///
/// Serializes [Locale] to string values under the `locale_code` key.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository.dart';
import 'package:flutter/material.dart';

/// Persists locale preference via non-sensitive local key-value storage.
final class LocaleRepositoryImpl implements LocaleRepository {
  /// Creates a repository backed by [localStorage].
  LocaleRepositoryImpl({required ILocalStorage localStorage})
      : _localStorage = localStorage;

  final ILocalStorage _localStorage;

  static const _key = 'locale_code';

  @override
  Future<Locale?> read() async {
    final raw = _localStorage.read<String>(key: _key);
    return _decode(raw);
  }

  @override
  Future<void> save(Locale? locale) async {
    await _localStorage.write(key: _key, value: _encode(locale));
  }

  @override
  Future<bool> hasPreference() async => _localStorage.containsKey(key: _key);

  static String _encode(Locale? locale) => switch (locale?.languageCode) {
        'en' => 'en',
        'id' => 'id',
        _ => 'system',
      };

  static Locale? _decode(String? raw) => switch (raw) {
        'en' => const Locale('en'),
        'id' => const Locale('id'),
        'system' || null => null,
        _ => null,
      };
}
