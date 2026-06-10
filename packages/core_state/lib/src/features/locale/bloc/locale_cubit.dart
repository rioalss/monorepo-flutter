/// BLoC cubit that loads and persists [Locale] preferences.
///
/// Emits locale changes immediately and persists them through
/// [LocaleRepository]. `null` state follows [SupportedLocales.defaultLocale].
library;

import 'dart:developer' as dev;
import 'dart:ui';

import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Manages app locale with persistence via [LocaleRepository].
@lazySingleton
class LocaleCubit extends Cubit<Locale?> {
  /// Starts with system locale until [load] reads stored preference.
  LocaleCubit(this._repository) : super(null);

  final LocaleRepository _repository;

  /// Loads the saved locale, or applies [SupportedLocales.defaultLocale] on first install.
  Future<void> load() async {
    final saved = await _repository.read();
    if (saved != null) {
      _logLocale(
        source: 'saved',
        locale: saved,
      );
      emit(saved);
      return;
    }

    final defaultLocale = SupportedLocales.defaultLocale;

    if (!await _repository.hasPreference()) {
      _logLocale(
        source: 'first_install',
        locale: defaultLocale,
      );
      emit(defaultLocale);
      await _repository.save(defaultLocale);
      return;
    }

    _logLocale(
      source: 'system',
      locale: defaultLocale,
    );
    emit(defaultLocale);
    await _repository.save(defaultLocale);
  }

  void _logLocale({
    required String source,
    required Locale? locale,
  }) {
    final resolved = locale?.toLanguageTag() ?? 'system';
    dev.log(
      'Default locale [$source]: $resolved | defaultLocale: ${SupportedLocales.defaultLocale.toLanguageTag()}',
      name: 'LocaleCubit',
    );
  }

  /// Switches to English and persists the choice.
  Future<void> setEnglish() async {
    const locale = Locale('en');
    emit(locale);
    await _repository.save(locale);
  }

  /// Switches to Indonesian and persists the choice.
  Future<void> setIndonesian() async {
    const locale = Locale('id');
    emit(locale);
    await _repository.save(locale);
  }

  /// Applies [SupportedLocales.defaultLocale] and persists the choice.
  Future<void> setSystem() async {
    final defaultLocale = SupportedLocales.defaultLocale;
    emit(defaultLocale);
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
    emit(next);
    await _repository.save(next);
  }
}
