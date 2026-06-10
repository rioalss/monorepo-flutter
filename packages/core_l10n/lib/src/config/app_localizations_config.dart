/// Centralized localization delegates and locale resolution for app shells.
library;

import 'package:core_l10n/src/config/device_locale_resolver.dart';
import 'package:core_l10n/src/constants/supported_locales.dart';
import 'package:core_l10n/src/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Static configuration for wiring [MaterialApp] localization.
abstract final class AppLocalizationsConfig {
  /// Locales exposed to the app shell.
  static const List<Locale> supportedLocales = SupportedLocales.all;

  /// Delegates required by [MaterialApp.localizationsDelegates].
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  /// Resolves the active locale, falling back to [SupportedLocales.fallback].
  ///
  /// When [locale] is `null` (system mode), returns [SupportedLocales.defaultLocale].
  static Locale? localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supported,
  ) {
    if (locale != null) {
      return DeviceLocaleResolver.resolveExplicit(locale, supported: supported);
    }

    return SupportedLocales.defaultLocale;
  }
}
