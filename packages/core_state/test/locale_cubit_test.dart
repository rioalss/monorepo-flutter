import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/src/features/locale/bloc/locale_cubit.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocaleCubit', () {
    late InMemoryLocaleRepository repository;
    late LocaleCubit cubit;

    setUp(() {
      repository = InMemoryLocaleRepository();
      cubit = LocaleCubit(repository);
    });

    tearDown(() => cubit.close());

    test('load applies and persists defaultLocale on first install', () async {
      await cubit.load();

      expect(cubit.state, SupportedLocales.defaultLocale);
      expect(await repository.hasPreference(), isTrue);
      expect(await repository.read(), SupportedLocales.defaultLocale);
    });

    test('load emits saved locale', () async {
      await repository.save(const Locale('id'));
      await cubit.load();
      expect(cubit.state, const Locale('id'));
    });

    test('load migrates legacy system preference to defaultLocale', () async {
      await repository.save(null);
      await cubit.load();
      expect(cubit.state, SupportedLocales.defaultLocale);
      expect(await repository.read(), SupportedLocales.defaultLocale);
    });

    test('cycle moves through en, id, and defaultLocale', () async {
      expect(cubit.state, isNull);

      await cubit.cycle();
      expect(cubit.state, const Locale('en'));

      await cubit.cycle();
      expect(cubit.state, const Locale('id'));

      await cubit.cycle();
      expect(cubit.state, SupportedLocales.defaultLocale);
    });

    test('setEnglish persists locale', () async {
      await cubit.setEnglish();
      expect(cubit.state, const Locale('en'));
      expect(await repository.read(), const Locale('en'));
    });

    test('setSystem persists defaultLocale', () async {
      await cubit.setEnglish();
      await cubit.setSystem();
      expect(cubit.state, SupportedLocales.defaultLocale);
      expect(await repository.read(), SupportedLocales.defaultLocale);
      expect(await repository.hasPreference(), isTrue);
    });
  });
}
