/// Chainable wrapper around `TextStyle` for fluent typography.
///
/// Intermediate methods return another builder; terminal methods produce a
/// `TextStyle`. See `AppTypography` for entry points.
library;

import 'package:design_system/src/colors/app_colors.dart';
import 'package:flutter/material.dart';

/// Fluent builder for composing [TextStyle] instances.
///
/// ```dart
/// AppTypography.fs17.medium.red()
/// AppTypography.fs14.regular.color(context.colorTokens.error)
/// ```
final class AppTextStyleBuilder {
  /// Wraps an existing [TextStyle] as the starting point for chaining.
  const AppTextStyleBuilder(this._style);

  final TextStyle _style;

  /// Underlying style without applying a terminal color.
  TextStyle get style => _style;

  /// Applies [FontWeight.w100].
  AppTextStyleBuilder get thin => _weight(FontWeight.w100);

  /// Applies [FontWeight.w300].
  AppTextStyleBuilder get light => _weight(FontWeight.w300);

  /// Applies [FontWeight.w400].
  AppTextStyleBuilder get regular => _weight(FontWeight.w400);

  /// Applies [FontWeight.w500].
  AppTextStyleBuilder get medium => _weight(FontWeight.w500);

  /// Applies [FontWeight.w600].
  AppTextStyleBuilder get semibold => _weight(FontWeight.w600);

  /// Applies [FontWeight.w700].
  AppTextStyleBuilder get bold => _weight(FontWeight.w700);

  /// Applies [FontWeight.w900].
  AppTextStyleBuilder get w900 => _weight(FontWeight.w900);

  /// Returns a new builder with selective [TextStyle] overrides.
  AppTextStyleBuilder copyWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      AppTextStyleBuilder(
        _style.copyWith(
          inherit: inherit,
          color: color,
          backgroundColor: backgroundColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          leadingDistribution: leadingDistribution,
          locale: locale,
          foreground: foreground,
          background: background,
          shadows: shadows,
          fontFeatures: fontFeatures,
          fontVariations: fontVariations,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          package: package,
          overflow: overflow,
        ),
      );

  /// Sets [TextStyle.height] to [value] (line-height multiplier).
  AppTextStyleBuilder heightOf(double value) => copyWith(height: value);

  /// Sets [TextStyle.letterSpacing] to [value].
  AppTextStyleBuilder letterSpacingOf(double value) =>
      copyWith(letterSpacing: value);

  /// Adds a single underline decoration.
  AppTextStyleBuilder get underline =>
      copyWith(decoration: TextDecoration.underline);

  /// Adds a strikethrough decoration.
  AppTextStyleBuilder get lineThrough =>
      copyWith(decoration: TextDecoration.lineThrough);

  /// Resolves to [TextStyle], optionally overriding color.
  ///
  /// When [color] is null, the style keeps its existing color (if any).
  TextStyle build({Color? color}) => _style.copyWith(color: color);

  /// Terminal: applies an arbitrary [value] color.
  TextStyle colorOf(Color value) => _style.copyWith(color: value);

  /// Terminal: applies [value] from theme tokens or any `Color`.
  TextStyle color(Color value) => colorOf(value);

  /// Terminal: [AppColors.error].
  TextStyle red() => _style.copyWith(color: AppColors.error);

  /// Terminal: static brand primary — ignores theme tokens.
  TextStyle primaryStatic() => _style.copyWith(color: AppColors.primary);

  /// Terminal: static success green — ignores theme tokens.
  TextStyle successStatic() => _style.copyWith(color: AppColors.success);

  /// Terminal: static warning amber — ignores theme tokens.
  TextStyle warningStatic() => _style.copyWith(color: AppColors.warning);

  /// Terminal: [Colors.white].
  TextStyle white() => _style.copyWith(color: Colors.white);

  /// Terminal: [Colors.black].
  TextStyle black() => _style.copyWith(color: Colors.black);

  /// Alias for [primaryStatic] — matches fluent `.primary()` naming.
  TextStyle primary() => primaryStatic();

  AppTextStyleBuilder _weight(FontWeight weight) =>
      AppTextStyleBuilder(_style.copyWith(fontWeight: weight));
}
