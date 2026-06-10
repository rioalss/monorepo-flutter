/// Logical pixel spacing scale and semantic layout constants.
///
/// Base unit is 8px (`sm`). Semantic aliases compose screen, card, and
/// component spacing from the scale tokens below.
library;

/// Spacing scale (px) and named layout gaps used across the design system.
abstract final class AppSpacing {
  /// 0px - No spacing
  static const double none = 0;

  /// 2px - Hairline spacing for tight elements
  static const double xxs = 2;

  /// 4px - Extra small spacing
  static const double xs = 4;

  /// 8px - Small spacing (base unit)
  static const double sm = 8;

  /// 12px - Medium-small spacing
  static const double md = 12;

  /// 16px - Medium spacing (2x base)
  static const double lg = 16;

  /// 20px - Medium-large spacing
  static const double xl = 20;

  /// 24px - Large spacing (3x base)
  static const double xxl = 24;

  /// 32px - Extra large spacing (4x base)
  static const double xxxl = 32;

  /// 40px - 2XL spacing (5x base)
  static const double huge = 40;

  /// 48px - 3XL spacing (6x base)
  static const double massive = 48;

  /// 56px - 4XL spacing (7x base)
  static const double gigantic = 56;

  /// 64px - 5XL spacing (8x base)
  static const double enormous = 64;

  /// 80px - 6XL spacing (10x base)
  static const double colossal = 80;

  /// 96px - 7XL spacing (12x base)
  static const double immense = 96;

  // ==================== Semantic Spacing ====================

  /// Screen horizontal padding
  static const double screenPaddingHorizontal = lg; // 16px

  /// Screen vertical padding
  static const double screenPaddingVertical = xl; // 20px

  /// Card internal padding
  static const double cardPadding = lg; // 16px

  /// Card internal padding (compact)
  static const double cardPaddingCompact = md; // 12px

  /// List item spacing
  static const double listItemSpacing = md; // 12px

  /// Section spacing
  static const double sectionSpacing = xxl; // 24px

  /// Icon to text spacing
  static const double iconTextSpacing = sm; // 8px

  /// Button internal padding horizontal
  static const double buttonPaddingHorizontal = lg; // 16px

  /// Button internal padding vertical
  static const double buttonPaddingVertical = md; // 12px

  /// Input field padding horizontal
  static const double inputPaddingHorizontal = lg; // 16px

  /// Input field padding vertical
  static const double inputPaddingVertical = md; // 12px

  /// Bottom sheet handle spacing
  static const double bottomSheetHandleSpacing = md; // 12px

  /// Modal padding
  static const double modalPadding = xxl; // 24px

  /// Safe area bottom (minimum)
  static const double safeAreaBottom = lg; // 16px

  /// App bar height
  static const double appBarHeight = 56;

  /// Bottom navigation height
  static const double bottomNavHeight = 80;

  /// FAB bottom margin
  static const double fabBottomMargin = lg; // 16px
}
