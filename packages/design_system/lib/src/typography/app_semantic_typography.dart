/// Default semantic typography roles declared via fluent `AppTypography`.
///
/// Consumed by `AppTypography` semantic helpers such as `heading1()`.
library;

import 'package:design_system/src/typography/app_typography.dart';
import 'package:flutter/material.dart';

/// Registry of named typographic roles.
abstract final class AppSemanticTypography {
  /// Headline large — page titles, hero headings.
  static TextStyle get heading1 => AppTypography.fs32.semibold.black();

  /// Headline medium — section headings.
  static TextStyle get heading2 => AppTypography.fs28.semibold.black();

  /// Headline small — sub-section headings.
  static TextStyle get heading3 => AppTypography.fs24.semibold.black();

  /// Body large — primary reading text.
  static TextStyle get body => AppTypography.fs16.regular.black();

  /// Body medium — secondary reading text.
  static TextStyle get bodySmall => AppTypography.fs14.regular.black();

  /// Body small — helper text, timestamps.
  static TextStyle get caption => AppTypography.fs12.regular.black();

  /// Label large — buttons, chips, form labels.
  static TextStyle get label => AppTypography.fs14.medium.black();
}
