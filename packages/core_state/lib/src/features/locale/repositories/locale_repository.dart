/// Locale preference persistence contract and in-memory default implementation.
///
/// Abstracts read/write of [Locale] so cubits and notifiers stay storage-
/// agnostic. `null` means follow the device locale.
library;

import 'package:flutter/material.dart';

/// Persists the user's locale preference.
abstract interface class LocaleRepository {
  /// Returns the last saved locale, or `null` to follow the system locale.
  Future<Locale?> read();

  /// Persists [locale] for subsequent [read] calls. Pass `null` for system.
  Future<void> save(Locale? locale);

  /// Whether a locale preference has ever been stored.
  Future<bool> hasPreference();
}

/// In-memory implementation for apps without local storage wired yet.
final class InMemoryLocaleRepository implements LocaleRepository {
  Locale? _locale;
  bool _hasPreference = false;

  @override
  Future<Locale?> read() async => _locale;

  @override
  Future<void> save(Locale? locale) async {
    _locale = locale;
    _hasPreference = true;
  }

  @override
  Future<bool> hasPreference() async => _hasPreference;
}
