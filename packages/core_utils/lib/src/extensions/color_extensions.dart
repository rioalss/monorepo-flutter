import 'package:flutter/material.dart';

/// [Color] opacity, adjustment, contrast, hex, gradient, and shadow helpers.
extension ColorExtensions on Color {
  // ==================== Opacity ====================

  /// Create color with custom opacity (0.0 - 1.0)
  Color withOpacityValue(double opacity) =>
      withValues(alpha: opacity.clamp(0.0, 1.0));

  /// 10% opacity
  Color get o10 => withOpacityValue(0.1);

  /// 20% opacity
  Color get o20 => withOpacityValue(0.2);

  /// 30% opacity
  Color get o30 => withOpacityValue(0.3);

  /// 40% opacity
  Color get o40 => withOpacityValue(0.4);

  /// 50% opacity
  Color get o50 => withOpacityValue(0.5);

  /// 60% opacity
  Color get o60 => withOpacityValue(0.6);

  /// 70% opacity
  Color get o70 => withOpacityValue(0.7);

  /// 80% opacity
  Color get o80 => withOpacityValue(0.8);

  /// 90% opacity
  Color get o90 => withOpacityValue(0.9);

  // ==================== Darken/Lighten ====================

  /// Darken color by percentage (0.0 - 1.0)
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Lighten color by percentage (0.0 - 1.0)
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  // ==================== Complementary ====================

  /// Get complementary color
  Color get complementary {
    final hsl = HSLColor.fromColor(this);
    return hsl.withHue((hsl.hue + 180) % 360).toColor();
  }

  /// Get inverted color
  Color get inverted => Color.fromARGB(
        a.toInt(),
        (255 - r).toInt(),
        (255 - g).toInt(),
        (255 - b).toInt(),
      );

  // ==================== Grayscale ====================

  /// Convert to grayscale
  Color get grayscale {
    final gray = (0.299 * r + 0.587 * g + 0.114 * b).round();
    return Color.fromARGB(a.toInt(), gray, gray, gray);
  }

  /// Check if color is dark
  bool get isDark => computeLuminance() < 0.5;

  /// Check if color is light
  bool get isLight => !isDark;

  /// Get contrasting text color (black or white)
  Color get contrastingTextColor => isDark ? Colors.white : Colors.black;

  // ==================== Hex ====================

  /// Convert to hex string
  String toHex({bool withHash = true, bool withAlpha = false}) {
    final prefix = withHash ? '#' : '';
    final alpha = withAlpha ? a.toInt().toRadixString(16).padLeft(2, '0') : '';
    final red = r.toInt().toRadixString(16).padLeft(2, '0');
    final green = g.toInt().toRadixString(16).padLeft(2, '0');
    final blue = b.toInt().toRadixString(16).padLeft(2, '0');
    return '$prefix$alpha$red$green$blue'.toUpperCase();
  }

  // ==================== Gradients ====================

  /// Create horizontal gradient with another color
  LinearGradient gradientWith(Color other) => LinearGradient(
        colors: [this, other],
      );

  /// Create vertical gradient with another color
  LinearGradient verticalGradientWith(Color other) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [this, other],
      );

  /// Create diagonal gradient with another color
  LinearGradient diagonalGradientWith(Color other) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [this, other],
      );

  // ==================== Material Color ====================

  /// Generate a MaterialColor swatch from this color
  MaterialColor toMaterialColor() {
    final strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
    final swatch = <int, Color>{};

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        (r + ((ds < 0 ? r : (255 - r)) * ds.abs())).round(),
        (g + ((ds < 0 ? g : (255 - g)) * ds.abs())).round(),
        (b + ((ds < 0 ? b : (255 - b)) * ds.abs())).round(),
        1,
      );
    }

    return MaterialColor(toARGB32(), swatch);
  }

  // ==================== Box Shadow ====================

  /// Create a box shadow with this color
  BoxShadow shadow({
    double blurRadius = 10,
    Offset offset = Offset.zero,
    double spreadRadius = 0,
    double opacity = 0.2,
  }) =>
      BoxShadow(
        color: withOpacityValue(opacity),
        blurRadius: blurRadius,
        offset: offset,
        spreadRadius: spreadRadius,
      );

  /// Create a soft shadow
  BoxShadow get softShadow => shadow(
        blurRadius: 20,
        offset: const Offset(0, 8),
        opacity: 0.15,
      );

  /// Create a card shadow
  BoxShadow get cardShadow => shadow(
        offset: const Offset(0, 4),
        opacity: 0.08,
      );

  /// Create a button shadow
  BoxShadow get buttonShadow => shadow(
        blurRadius: 15,
        offset: const Offset(0, 6),
        opacity: 0.25,
      );
}
