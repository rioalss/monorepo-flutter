/// Static brand and neutral color primitives.
///
/// Prefer [AppColorTokens] or `Theme.of(context).colorScheme` in widgets.
/// These values are the source palette for light/dark token generation.
library;

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Raw hex-defined colors — not brightness-aware on their own.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFFFD6B22);
  static const Color primaryLight = Color(0xFFFF9A8E);
  static const Color primaryDark = Color(0xFFE05A15);
  static const Color primaryContainerLight = Color(0xFFFFE4D6);
  static const Color primaryContainerDark = Color(0xFF5C2D14);

  // Neutrals — light
  static const Color backgroundLight = Color(0xFFF8F9FB);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFE5E7EB);
  static const Color onSurfaceLight = Color(0xFF1A1D26);
  static const Color onSurfaceVariantLight = Color(0xFF6B7280);
  static const Color outlineLight = Color(0xFF9CA3AF);
  static const Color outlineVariantLight = Color(0xFFE5E7EB);

  // Neutrals — dark
  static const Color backgroundDark = Color(0xFF12141A);
  static const Color surfaceDark = Color(0xFF1A1D26);
  static const Color cardDark = Color(0xFF22252E);
  static const Color surfaceVariantDark = Color(0xFF2D3038);
  static const Color onSurfaceDark = Color(0xFFF3F4F6);
  static const Color onSurfaceVariantDark = Color(0xFF9CA3AF);
  static const Color outlineDark = Color(0xFF6B7280);
  static const Color outlineVariantDark = Color(0xFF374151);

  // Semantic
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFFFB4AB);
  static const Color errorContainerLight = Color(0xFFFFDAD6);
  static const Color errorContainerDark = Color(0xFF93000A);
  static const Color onErrorContainerLight = Color(0xFF410002);
  static const Color onErrorContainerDark = Color(0xFFFFDAD6);

  static const Color success = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF86EFAC);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFFFCD34D);

  static const Color secondary = Color(0xFF4B5563);
  static const Color secondaryDark = Color(0xFFCBD5E1);
  static const Color tertiary = Color(0xFF6366F1);

  static const Color shadow = Color(0xFF1A1D26);
  static const Color scrim = Color(0xFF000000);
}
