/// BLoC cubit that loads and persists [ThemeMode] preferences.
///
/// Emits theme changes immediately and persists them through
/// [ThemeRepository].

library;

import 'package:core_state/src/features/theme/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Manages app theme mode with persistence via [ThemeRepository].
@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  /// Starts in [ThemeMode.system] until [load] reads stored preference.
  ThemeCubit(this._repository) : super(ThemeMode.system);

  final ThemeRepository _repository;

  /// Loads the saved theme mode from [ThemeRepository].
  Future<void> load() async {
    emit(await _repository.read());
  }

  /// Switches to light mode and persists the choice.
  Future<void> setLight() async {
    emit(ThemeMode.light);
    await _repository.save(ThemeMode.light);
  }

  /// Switches to dark mode and persists the choice.
  Future<void> setDark() async {
    emit(ThemeMode.dark);
    await _repository.save(ThemeMode.dark);
  }

  /// Follows system appearance and persists the choice.
  Future<void> setSystem() async {
    emit(ThemeMode.system);
    await _repository.save(ThemeMode.system);
  }

  /// Toggles between light and dark; ignores [ThemeMode.system].
  Future<void> toggle() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(next);
    await _repository.save(next);
  }

  /// Cycles light → dark → system → light and persists each step.
  Future<void> cycle() async {
    final next = switch (state) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    emit(next);
    await _repository.save(next);
  }
}
