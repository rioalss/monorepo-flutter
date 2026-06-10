/// GetX controller that loads and persists [Locale] preferences.
///
/// Exposes reactive [locale] and mirrors [LocaleCubit] behavior for GetX apps.
library;

import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// Reactive locale manager backed by [LocaleRepository].
@lazySingleton
class LocaleController extends GetxController {
  /// Creates a controller with the given [repository].
  LocaleController(this._repository);

  final LocaleRepository _repository;

  /// Observable current locale; `null` follows [SupportedLocales.defaultLocale].
  final Rxn<Locale> locale = Rxn<Locale>();

  /// Loads the saved locale, or applies [SupportedLocales.defaultLocale] on first install.
  Future<void> load() async {
    final saved = await _repository.read();
    if (saved != null) {
      locale.value = saved;
      return;
    }

    final defaultLocale = SupportedLocales.defaultLocale;

    if (!await _repository.hasPreference()) {
      locale.value = defaultLocale;
      await _repository.save(defaultLocale);
      return;
    }

    locale.value = defaultLocale;
    await _repository.save(defaultLocale);
  }

  /// Switches to English and persists the choice.
  Future<void> setEnglish() async {
    const value = Locale('en');
    locale.value = value;
    await _repository.save(value);
  }

  /// Switches to Indonesian and persists the choice.
  Future<void> setIndonesian() async {
    const value = Locale('id');
    locale.value = value;
    await _repository.save(value);
  }

  /// Applies [SupportedLocales.defaultLocale] and persists the choice.
  Future<void> setSystem() async {
    final defaultLocale = SupportedLocales.defaultLocale;
    locale.value = defaultLocale;
    await _repository.save(defaultLocale);
  }

  /// Cycles default → English → Indonesian → default and persists each step.
  Future<void> cycle() async {
    final defaultLocale = SupportedLocales.defaultLocale;
    final next = switch (locale.value?.languageCode) {
      'en' => const Locale('id'),
      'id' => defaultLocale,
      _ => const Locale('en'),
    };
    locale.value = next;
    await _repository.save(next);
  }
}
