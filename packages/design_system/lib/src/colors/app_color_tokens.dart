/// Theme-aware semantic color tokens for Material 3.
///
/// Registered as a `ThemeExtension` alongside `ColorScheme`. Use
/// `context.colorTokens` (see `AppThemeContext`) in widgets.
library;

import 'package:design_system/src/colors/app_colors.dart';
import 'package:flutter/material.dart';

/// Full semantic palette for one brightness mode.
@immutable
final class AppColorTokens extends ThemeExtension<AppColorTokens> {
  /// Creates a complete token set; all colors are required except [cardSurface].
  const AppColorTokens({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    this.cardSurface,
  });

  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;

  /// Elevated card surface; set in dark theme, null in light (uses [surface]).
  final Color? cardSurface;

  /// Default light-theme token set derived from [AppColors].
  static const light = AppColorTokens(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryContainerLight,
    onPrimaryContainer: Color(0xFF3D1600),
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFE5E7EB),
    onSecondaryContainer: Color(0xFF1F2937),
    tertiary: AppColors.tertiary,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFE0E7FF),
    onTertiaryContainer: Color(0xFF1E1B4B),
    error: AppColors.error,
    onError: Colors.white,
    errorContainer: AppColors.errorContainerLight,
    onErrorContainer: AppColors.onErrorContainerLight,
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    surfaceVariant: AppColors.surfaceVariantLight,
    onSurface: AppColors.onSurfaceLight,
    onSurfaceVariant: AppColors.onSurfaceVariantLight,
    outline: AppColors.outlineLight,
    outlineVariant: AppColors.outlineVariantLight,
    shadow: AppColors.shadow,
    scrim: AppColors.scrim,
    inverseSurface: AppColors.onSurfaceLight,
    inverseOnSurface: AppColors.surfaceLight,
    inversePrimary: AppColors.primaryLight,
  );

  /// Default dark-theme token set derived from [AppColors].
  static const dark = AppColorTokens(
    brightness: Brightness.dark,
    primary: AppColors.primaryLight,
    onPrimary: Color(0xFF3D1600),
    primaryContainer: AppColors.primaryContainerDark,
    onPrimaryContainer: AppColors.primaryContainerLight,
    secondary: AppColors.secondaryDark,
    onSecondary: Color(0xFF1F2937),
    secondaryContainer: Color(0xFF374151),
    onSecondaryContainer: AppColors.secondaryDark,
    tertiary: Color(0xFFA5B4FC),
    onTertiary: Color(0xFF1E1B4B),
    tertiaryContainer: Color(0xFF312E81),
    onTertiaryContainer: Color(0xFFE0E7FF),
    error: AppColors.errorDark,
    onError: Color(0xFF690005),
    errorContainer: AppColors.errorContainerDark,
    onErrorContainer: AppColors.onErrorContainerDark,
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    surfaceVariant: AppColors.surfaceVariantDark,
    onSurface: AppColors.onSurfaceDark,
    onSurfaceVariant: AppColors.onSurfaceVariantDark,
    outline: AppColors.outlineDark,
    outlineVariant: AppColors.outlineVariantDark,
    shadow: Colors.black,
    scrim: AppColors.scrim,
    inverseSurface: AppColors.onSurfaceDark,
    inverseOnSurface: AppColors.surfaceDark,
    inversePrimary: AppColors.primary,
    cardSurface: AppColors.cardDark,
  );

  /// Maps tokens to a Material 3 [ColorScheme] for [ThemeData].
  ColorScheme toColorScheme() => ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        surfaceContainerHighest: surfaceVariant,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        shadow: shadow,
        scrim: scrim,
        inverseSurface: inverseSurface,
        onInverseSurface: inverseOnSurface,
        inversePrimary: inversePrimary,
      );

  @override
  /// Returns a copy with selectively replaced colors; omitted fields are kept.
  AppColorTokens copyWith({
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? inverseOnSurface,
    Color? inversePrimary,
    Color? cardSurface,
  }) =>
      AppColorTokens(
        brightness: brightness ?? this.brightness,
        primary: primary ?? this.primary,
        onPrimary: onPrimary ?? this.onPrimary,
        primaryContainer: primaryContainer ?? this.primaryContainer,
        onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
        secondary: secondary ?? this.secondary,
        onSecondary: onSecondary ?? this.onSecondary,
        secondaryContainer: secondaryContainer ?? this.secondaryContainer,
        onSecondaryContainer:
            onSecondaryContainer ?? this.onSecondaryContainer,
        tertiary: tertiary ?? this.tertiary,
        onTertiary: onTertiary ?? this.onTertiary,
        tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
        error: error ?? this.error,
        onError: onError ?? this.onError,
        errorContainer: errorContainer ?? this.errorContainer,
        onErrorContainer: onErrorContainer ?? this.onErrorContainer,
        background: background ?? this.background,
        surface: surface ?? this.surface,
        surfaceVariant: surfaceVariant ?? this.surfaceVariant,
        onSurface: onSurface ?? this.onSurface,
        onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
        outline: outline ?? this.outline,
        outlineVariant: outlineVariant ?? this.outlineVariant,
        shadow: shadow ?? this.shadow,
        scrim: scrim ?? this.scrim,
        inverseSurface: inverseSurface ?? this.inverseSurface,
        inverseOnSurface: inverseOnSurface ?? this.inverseOnSurface,
        inversePrimary: inversePrimary ?? this.inversePrimary,
        cardSurface: cardSurface ?? this.cardSurface,
      );

  @override
  /// Interpolates each color; brightness switches at t = 0.5.
  ///
  /// Returns `this` when [other] is not an `AppColorTokens`.
  AppColorTokens lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      brightness: t < 0.5 ? brightness : other.brightness,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer:
          Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer:
          Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondaryContainer:
          Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer:
          Color.lerp(tertiaryContainer, other.tertiaryContainer, t)!,
      onTertiaryContainer:
          Color.lerp(onTertiaryContainer, other.onTertiaryContainer, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer:
          Color.lerp(onErrorContainer, other.onErrorContainer, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      inverseOnSurface:
          Color.lerp(inverseOnSurface, other.inverseOnSurface, t)!,
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t)!,
      cardSurface: Color.lerp(cardSurface, other.cardSurface, t),
    );
  }
}
