/// Pre-built light and dark [ThemeData] for the app shell.
library;

import 'package:design_system/src/colors/app_color_tokens.dart';
import 'package:design_system/src/theme/builders/app_theme_builder.dart';
import 'package:flutter/material.dart';

/// Static accessors for app-wide [ThemeData] instances.
abstract final class AppTheme {
  /// Light theme using [AppColorTokens.light].
  static ThemeData get light => AppThemeBuilder.build(AppColorTokens.light);

  /// Dark theme using [AppColorTokens.dark].
  static ThemeData get dark => AppThemeBuilder.build(AppColorTokens.dark);

  /// Returns [dark] or [light] based on [brightness].
  static ThemeData forBrightness(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;
}
