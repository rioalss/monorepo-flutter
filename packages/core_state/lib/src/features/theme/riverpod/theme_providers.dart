/// Riverpod providers and notifier for [ThemeMode] preferences.
///
/// Requires [localStorageProvider] to be overridden after Hive initialization.

library;

import 'package:core_state/src/di/riverpod/infrastructure_providers.dart';
import 'package:core_state/src/features/theme/repositories/theme_repository.dart';
import 'package:core_state/src/features/theme/repositories/theme_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Source of truth for theme persistence in Riverpod apps.
final themeRepositoryProvider = Provider<ThemeRepository>(
  (ref) => ThemeRepositoryImpl(
    localStorage: ref.watch(localStorageProvider),
  ),
);

/// Manages [ThemeMode] state with persistence via [ThemeRepository].
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  ThemeRepository get _repository => ref.read(themeRepositoryProvider);

  /// Loads the saved theme mode from [ThemeRepository].
  Future<void> load() async {
    state = await _repository.read();
  }

  /// Switches to light mode and persists the choice.
  Future<void> setLight() async {
    state = ThemeMode.light;
    await _repository.save(ThemeMode.light);
  }

  /// Switches to dark mode and persists the choice.
  Future<void> setDark() async {
    state = ThemeMode.dark;
    await _repository.save(ThemeMode.dark);
  }

  /// Follows system appearance and persists the choice.
  Future<void> setSystem() async {
    state = ThemeMode.system;
    await _repository.save(ThemeMode.system);
  }

  /// Toggles between light and dark; ignores [ThemeMode.system].
  Future<void> toggle() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = next;
    await _repository.save(next);
  }

  /// Cycles light → dark → system → light and persists each step.
  Future<void> cycle() async {
    final next = switch (state) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    state = next;
    await _repository.save(next);
  }
}

/// Global theme mode provider for Riverpod apps.
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
