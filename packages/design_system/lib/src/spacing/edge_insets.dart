/// Pre-composed [EdgeInsets] built from [AppSpacing] tokens.
///
/// Use these instead of raw `EdgeInsets.all(...)` to keep padding consistent
/// with the design system scale.
library;

import 'package:design_system/src/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

/// Named [EdgeInsets] presets aligned with [AppSpacing].
abstract final class AppEdgeInsets {
  // ==================== Symmetric Padding ====================

  /// No padding
  static const EdgeInsets none = EdgeInsets.zero;

  /// Horizontal padding - xs (4px)
  static const EdgeInsets horizontalXs =
      EdgeInsets.symmetric(horizontal: AppSpacing.xs);

  /// Horizontal padding - sm (8px)
  static const EdgeInsets horizontalSm =
      EdgeInsets.symmetric(horizontal: AppSpacing.sm);

  /// Horizontal padding - md (12px)
  static const EdgeInsets horizontalMd =
      EdgeInsets.symmetric(horizontal: AppSpacing.md);

  /// Horizontal padding - lg (16px)
  static const EdgeInsets horizontalLg =
      EdgeInsets.symmetric(horizontal: AppSpacing.lg);

  /// Horizontal padding - xl (20px)
  static const EdgeInsets horizontalXl =
      EdgeInsets.symmetric(horizontal: AppSpacing.xl);

  /// Horizontal padding - xxl (24px)
  static const EdgeInsets horizontalXxl =
      EdgeInsets.symmetric(horizontal: AppSpacing.xxl);

  /// Vertical padding - xs (4px)
  static const EdgeInsets verticalXs =
      EdgeInsets.symmetric(vertical: AppSpacing.xs);

  /// Vertical padding - sm (8px)
  static const EdgeInsets verticalSm =
      EdgeInsets.symmetric(vertical: AppSpacing.sm);

  /// Vertical padding - md (12px)
  static const EdgeInsets verticalMd =
      EdgeInsets.symmetric(vertical: AppSpacing.md);

  /// Vertical padding - lg (16px)
  static const EdgeInsets verticalLg =
      EdgeInsets.symmetric(vertical: AppSpacing.lg);

  /// Vertical padding - xl (20px)
  static const EdgeInsets verticalXl =
      EdgeInsets.symmetric(vertical: AppSpacing.xl);

  /// Vertical padding - xxl (24px)
  static const EdgeInsets verticalXxl =
      EdgeInsets.symmetric(vertical: AppSpacing.xxl);

  // ==================== All Sides Padding ====================

  /// All sides - xs (4px)
  static const EdgeInsets allXs = EdgeInsets.all(AppSpacing.xs);

  /// All sides - sm (8px)
  static const EdgeInsets allSm = EdgeInsets.all(AppSpacing.sm);

  /// All sides - md (12px)
  static const EdgeInsets allMd = EdgeInsets.all(AppSpacing.md);

  /// All sides - lg (16px)
  static const EdgeInsets allLg = EdgeInsets.all(AppSpacing.lg);

  /// All sides - xl (20px)
  static const EdgeInsets allXl = EdgeInsets.all(AppSpacing.xl);

  /// All sides - xxl (24px)
  static const EdgeInsets allXxl = EdgeInsets.all(AppSpacing.xxl);

  /// All sides - xxxl (32px)
  static const EdgeInsets allXxxl = EdgeInsets.all(AppSpacing.xxxl);

  // ==================== Screen Padding ====================

  /// Standard screen padding: 16px horizontal, 20px vertical
  static const EdgeInsets screen = EdgeInsets.symmetric(
    horizontal: AppSpacing.screenPaddingHorizontal,
    vertical: AppSpacing.screenPaddingVertical,
  );

  /// Screen horizontal padding only: 16px
  static const EdgeInsets screenHorizontal = EdgeInsets.symmetric(
    horizontal: AppSpacing.screenPaddingHorizontal,
  );

  /// Screen vertical padding only: 20px
  static const EdgeInsets screenVertical = EdgeInsets.symmetric(
    vertical: AppSpacing.screenPaddingVertical,
  );

  // ==================== Component Padding ====================

  /// Card padding: 16px
  static const EdgeInsets card = EdgeInsets.all(AppSpacing.cardPadding);

  /// Card padding compact: 12px
  static const EdgeInsets cardCompact =
      EdgeInsets.all(AppSpacing.cardPaddingCompact);

  /// Button padding: 16px horizontal, 12px vertical
  static const EdgeInsets button = EdgeInsets.symmetric(
    horizontal: AppSpacing.buttonPaddingHorizontal,
    vertical: AppSpacing.buttonPaddingVertical,
  );

  /// Input field padding: 16px horizontal, 12px vertical
  static const EdgeInsets input = EdgeInsets.symmetric(
    horizontal: AppSpacing.inputPaddingHorizontal,
    vertical: AppSpacing.inputPaddingVertical,
  );

  /// Modal padding: 24px
  static const EdgeInsets modal = EdgeInsets.all(AppSpacing.modalPadding);

  /// List item padding: 16px horizontal, 12px vertical
  static const EdgeInsets listItem = EdgeInsets.symmetric(
    horizontal: AppSpacing.screenPaddingHorizontal,
    vertical: AppSpacing.listItemSpacing,
  );

  /// Chip padding: 12px horizontal, 4px vertical
  static const EdgeInsets chip = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.xs,
  );

  /// Badge padding: 8px horizontal, 2px vertical
  static const EdgeInsets badge = EdgeInsets.symmetric(
    horizontal: AppSpacing.sm,
    vertical: AppSpacing.xxs,
  );

  /// Bottom sheet padding: 16px left, 12px top, 16px right, 16px bottom
  static const EdgeInsets bottomSheet = EdgeInsets.fromLTRB(
    AppSpacing.lg,
    AppSpacing.bottomSheetHandleSpacing,
    AppSpacing.lg,
    AppSpacing.safeAreaBottom,
  );

  /// Tab bar padding: 16px horizontal
  static const EdgeInsets tabBar = EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
  );

  /// Nav bar padding: 12px vertical only.
  static const EdgeInsets navBar = EdgeInsets.symmetric(
    vertical: AppSpacing.md,
  );
}
