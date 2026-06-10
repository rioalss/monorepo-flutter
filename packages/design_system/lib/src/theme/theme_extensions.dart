/// Convenience extensions for reading theme and color tokens from context.
library;

import 'package:design_system/src/colors/app_color_tokens.dart';
import 'package:flutter/material.dart';

/// Shortcuts on [BuildContext] for theme and token access.
extension AppThemeContext on BuildContext {
  /// Shorthand for [Theme.of].
  ThemeData get appTheme => Theme.of(this);

  /// Active [ColorScheme] from [appTheme].
  ColorScheme get colors => appTheme.colorScheme;

  /// Whether the current theme is dark.
  bool get isDarkMode => appTheme.brightness == Brightness.dark;

  /// Semantic color tokens; falls back to [AppColorTokens.light] if missing.
  AppColorTokens get colorTokens =>
      appTheme.extension<AppColorTokens>() ?? AppColorTokens.light;
}

/// Resolves [AppColorTokens] directly from [ThemeData].
extension ThemeDataColorExtensions on ThemeData {
  /// Semantic tokens attached to this theme, or [AppColorTokens.light].
  AppColorTokens get colorTokens =>
      extension<AppColorTokens>() ?? AppColorTokens.light;
}
