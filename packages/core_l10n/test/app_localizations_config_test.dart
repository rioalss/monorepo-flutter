import 'dart:ui';

import 'package:core_l10n/core_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLocalizationsConfig', () {
    test('supportedLocales contains en and id', () {
      expect(AppLocalizationsConfig.supportedLocales, hasLength(2));
      expect(
        AppLocalizationsConfig.supportedLocales.map((l) => l.languageCode),
        containsAll(['en', 'id']),
      );
    });

    test('localizationsDelegates is not empty', () {
      expect(AppLocalizationsConfig.localizationsDelegates, isNotEmpty);
    });

    test('localeResolutionCallback falls back to en for unsupported locale', () {
      final resolved = AppLocalizationsConfig.localeResolutionCallback(
        const Locale('fr'),
        AppLocalizationsConfig.supportedLocales,
      );

      expect(resolved, const Locale('en'));
    });

    test('localeResolutionCallback matches supported language code', () {
      final resolved = AppLocalizationsConfig.localeResolutionCallback(
        const Locale('id', 'ID'),
        AppLocalizationsConfig.supportedLocales,
      );

      expect(resolved, const Locale('id'));
    });

    test(
      'localeResolutionCallback returns defaultLocale when locale is null',
      () {
        final resolved = AppLocalizationsConfig.localeResolutionCallback(
          null,
          AppLocalizationsConfig.supportedLocales,
        );

        expect(resolved, SupportedLocales.defaultLocale);
      },
    );
  });
}
