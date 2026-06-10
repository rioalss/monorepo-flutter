/// Context-aware helpers for commonly used semantic colors.
///
/// Resolves theme tokens at runtime so widgets stay correct in light/dark
/// mode without importing raw [AppColors] values.
library;

import 'package:design_system/src/colors/app_color_tokens.dart';
import 'package:design_system/src/colors/app_colors.dart';
import 'package:flutter/material.dart';

/// Static accessors that read from the active [ThemeData].
abstract final class SemanticColors {
  /// Resolves [AppColorTokens] from [context], falling back to [AppColorTokens.light].
  static AppColorTokens _tokens(BuildContext context) =>
      Theme.of(context).extension<AppColorTokens>() ?? AppColorTokens.light;

  /// Brand primary from [AppColorTokens].
  static Color primary(BuildContext context) => _tokens(context).primary;

  /// Error color from [ColorScheme.error] (Material mapping).
  static Color error(BuildContext context) => Theme.of(context).colorScheme.error;

  /// Success green — switches between light and dark palette variants.
  static Color success(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.successDark
          : AppColors.success;

  /// Warning amber — switches between light and dark palette variants.
  static Color warning(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.warningDark
          : AppColors.warning;
}
