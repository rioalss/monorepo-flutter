/// Builds [ThemeData] from [AppColorTokens].
library;

import 'package:design_system/src/colors/app_color_tokens.dart';
import 'package:flutter/material.dart';

/// Assembles Material 3 [ThemeData] from design tokens.
abstract final class AppThemeBuilder {
  /// Creates a theme with M3 enabled, [tokens] as [ColorScheme], and
  /// [AppColorTokens] registered in [ThemeData.extensions].
  static ThemeData build(AppColorTokens tokens) => ThemeData(
        useMaterial3: true,
        brightness: tokens.brightness,
        colorScheme: tokens.toColorScheme(),
        extensions: [tokens],
      );
}
