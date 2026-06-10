/// Riverpod providers and notifier for [Locale] preferences.
///
/// Requires [localStorageProvider] to be overridden after Hive initialization.
library;

import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/src/di/riverpod/infrastructure_providers.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Source of truth for locale persistence in Riverpod apps.
final localeRepositoryProvider = Provider<LocaleRepository>(
  (ref) => LocaleRepositoryImpl(
    localStorage: ref.watch(localStorageProvider),
  ),
);

/// Manages [Locale] state with persistence via [LocaleRepository].
class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() => null;

  LocaleRepository get _repository => ref.read(localeRepositoryProvider);

  /// Loads the saved locale, or applies [SupportedLocales.defaultLocale] on first install.
  Future<void> load() async {
    final saved = await _repository.read();
    if (saved != null) {
      state = saved;
      return;
    }

    final defaultLocale = SupportedLocales.defaultLocale;

    if (!await _repository.hasPreference()) {
      state = defaultLocale;
      await _repository.save(defaultLocale);
      return;
    }

    state = defaultLocale;
    await _repository.save(defaultLocale);
  }

  /// Switches to English and persists the choice.
  Future<void> setEnglish() async {
    const locale = Locale('en');
    state = locale;
    await _repository.save(locale);
  }

  /// Switches to Indonesian and persists the choice.
  Future<void> setIndonesian() async {
    const locale = Locale('id');
    state = locale;
    await _repository.save(locale);
  }

  /// Applies [SupportedLocales.defaultLocale] and persists the choice.
  Future<void> setSystem() async {
    final defaultLocale = SupportedLocales.defaultLocale;
    state = defaultLocale;
    await _repository.save(defaultLocale);
  }

  /// Cycles default → English → Indonesian → default and persists each step.
  Future<void> cycle() async {
    final defaultLocale = SupportedLocales.defaultLocale;
    final next = switch (state?.languageCode) {
      'en' => const Locale('id'),
      'id' => defaultLocale,
      _ => const Locale('en'),
    };
    state = next;
    await _repository.save(next);
  }
}

/// Global locale provider for Riverpod apps.
final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);
