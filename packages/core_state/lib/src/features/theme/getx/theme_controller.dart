/// GetX controller that loads and persists [ThemeMode] preferences.
///
/// Exposes reactive [themeMode] and mirrors [ThemeCubit] behavior for GetX apps.

library;

import 'package:core_state/src/features/theme/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// Reactive theme manager backed by [ThemeRepository].
@lazySingleton
class ThemeController extends GetxController {
  /// Creates a controller with the given [repository].
  ThemeController(this._repository);

  final ThemeRepository _repository;

  /// Observable current theme mode; defaults to [ThemeMode.system].
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  /// Loads the saved theme mode from [ThemeRepository].
  Future<void> load() async {
    themeMode.value = await _repository.read();
  }

  /// Switches to light mode and persists the choice.
  Future<void> setLight() async {
    themeMode.value = ThemeMode.light;
    await _repository.save(ThemeMode.light);
  }

  /// Switches to dark mode and persists the choice.
  Future<void> setDark() async {
    themeMode.value = ThemeMode.dark;
    await _repository.save(ThemeMode.dark);
  }

  /// Follows system appearance and persists the choice.
  Future<void> setSystem() async {
    themeMode.value = ThemeMode.system;
    await _repository.save(ThemeMode.system);
  }

  /// Toggles between light and dark; ignores [ThemeMode.system].
  Future<void> toggle() async {
    final next = themeMode.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    themeMode.value = next;
    await _repository.save(next);
  }

  /// Cycles light → dark → system → light and persists each step.
  Future<void> cycle() async {
    final next = switch (themeMode.value) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    themeMode.value = next;
    await _repository.save(next);
  }
}
