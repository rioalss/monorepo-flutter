/// Supported app locales and helpers for locale resolution.
library;

import 'package:flutter/material.dart';

/// App-supported locale identifiers.
enum AppLocale {
  /// English.
  en,

  /// Indonesian.
  id,
}

/// Static accessors for supported [Locale] instances.
abstract final class SupportedLocales {
  /// All locales wired into [MaterialApp.supportedLocales].
  static const List<Locale> all = [
    Locale('en'),
    Locale('id'),
  ];

  /// Default locale when the device locale is not supported.
  static const Locale fallback = Locale('en');

  /// App locale used on first install and when the user chooses system.
  ///
  /// Change to [AppLocale.id] for Bahasa Indonesia as the default.
  static const AppLocale defaultAppLocale = AppLocale.en;

  /// Hardcoded default [Locale] derived from [defaultAppLocale].
  static Locale get defaultLocale => toLocale(defaultAppLocale);

  /// Maps a [Locale] to [AppLocale], or `null` if unsupported.
  static AppLocale? fromLocale(Locale locale) {
    final languageCode = locale.languageCode.toLowerCase();
    return switch (languageCode) {
      'en' => AppLocale.en,
      'id' => AppLocale.id,
      _ => null,
    };
  }

  /// Converts [AppLocale] to a Flutter [Locale].
  static Locale toLocale(AppLocale locale) => switch (locale) {
        AppLocale.en => const Locale('en'),
        AppLocale.id => const Locale('id'),
      };

  /// Human-readable label for settings UI.
  static String displayName(AppLocale locale) => switch (locale) {
        AppLocale.en => 'English',
        AppLocale.id => 'Bahasa Indonesia',
      };
}
