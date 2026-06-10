/// Resolves explicit locales against app-supported locales.
library;

import 'dart:ui';

import 'package:core_l10n/src/constants/supported_locales.dart';

/// Matches a [Locale] against app-supported locales.
abstract final class DeviceLocaleResolver {
  /// Returns [locale] when supported, otherwise [fallback].
  static Locale resolveExplicit(
    Locale locale, {
    Iterable<Locale> supported = SupportedLocales.all,
    Locale fallback = SupportedLocales.fallback,
  }) {
    for (final supportedLocale in supported) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return fallback;
  }
}
