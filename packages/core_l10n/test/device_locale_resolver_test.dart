import 'dart:ui';

import 'package:core_l10n/core_l10n.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeviceLocaleResolver', () {
    test('resolveExplicit returns matching supported locale', () {
      final resolved = DeviceLocaleResolver.resolveExplicit(
        const Locale('id', 'ID'),
      );

      expect(resolved, const Locale('id'));
    });

    test('resolveExplicit falls back for unsupported locale', () {
      final resolved = DeviceLocaleResolver.resolveExplicit(
        const Locale('fr'),
      );

      expect(resolved, SupportedLocales.fallback);
    });
  });
}
