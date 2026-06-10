/// Corner radius scale and component-specific [BorderRadius] presets.
library;

import 'package:flutter/material.dart';

/// Radius values (px) and semantic border radii for common UI surfaces.
abstract final class AppRadius {
  // ==================== Values ====================

  /// No radius - sharp corners
  static const double none = 0;

  /// Extra small - 4px (subtle rounding)
  static const double xs = 4;

  /// Small - 8px (standard rounding)
  static const double sm = 8;

  /// Medium - 12px (card rounding)
  static const double md = 12;

  /// Large - 16px (prominent rounding)
  static const double lg = 16;

  /// Extra large - 20px (modal rounding)
  static const double xl = 20;

  /// 2XL - 24px (pill shape start)
  static const double xxl = 24;

  /// 3XL - 32px (large pill)
  static const double xxxl = 32;

  /// Full - 9999px (completely round)
  static const double full = 9999;

  // ==================== BorderRadius ====================

  /// No border radius
  static const BorderRadius noneRadius = BorderRadius.zero;

  /// Extra small border radius: 4px
  static BorderRadius get xsRadius => BorderRadius.circular(xs);

  /// Small border radius: 8px
  static BorderRadius get smRadius => BorderRadius.circular(sm);

  /// Medium border radius: 12px
  static BorderRadius get mdRadius => BorderRadius.circular(md);

  /// Large border radius: 16px
  static BorderRadius get lgRadius => BorderRadius.circular(lg);

  /// Extra large border radius: 20px
  static BorderRadius get xlRadius => BorderRadius.circular(xl);

  /// 2XL border radius: 24px
  static BorderRadius get xxlRadius => BorderRadius.circular(xxl);

  /// 3XL border radius: 32px
  static BorderRadius get xxxlRadius => BorderRadius.circular(xxxl);

  /// Full border radius (pill shape): 9999px
  static BorderRadius get fullRadius => BorderRadius.circular(full);

  /// Vertical-only rounding; null radii default to 0 (sharp corner).
  static BorderRadius vertical(double? top, double? bottom) =>
      BorderRadius.vertical(
        top: Radius.circular(top ?? 0),
        bottom: Radius.circular(bottom ?? 0),
      );

  // ==================== Semantic Radii ====================

  /// Card border radius: 12px
  static BorderRadius get card => mdRadius;

  /// Button border radius: 12px
  static BorderRadius get button => mdRadius;

  /// Button border radius (large): 16px
  static BorderRadius get buttonLarge => lgRadius;

  /// Button border radius (pill): 9999px (completely round)
  static BorderRadius get buttonPill => fullRadius;

  /// Input field border radius: 16px
  static BorderRadius get input => lgRadius;

  /// Chip border radius: 9999px (completely round)
  static BorderRadius get chip => fullRadius;

  /// Badge border radius: 8px
  static BorderRadius get badge => smRadius;

  /// Avatar border radius: 9999px (completely round)
  static BorderRadius get avatar => fullRadius;

  /// Bottom sheet border radius: 20px top left and top right
  static BorderRadius get bottomSheet => const BorderRadius.only(
        topLeft: Radius.circular(xl),
        topRight: Radius.circular(xl),
      );

  /// Modal border radius: 20px
  static BorderRadius get modal => xlRadius;

  /// Tooltip border radius: 8px
  static BorderRadius get tooltip => smRadius;

  /// Image border radius: 12px
  static BorderRadius get image => mdRadius;

  /// Skeleton/shimmer border radius: 8px
  static BorderRadius get skeleton => smRadius;

  /// Search bar border radius: 9999px (completely round)
  static BorderRadius get searchBar => fullRadius;

  /// Tab indicator border radius: 9999px (completely round)
  static BorderRadius get tabIndicator => fullRadius;

  /// Snackbar border radius: 8px
  static BorderRadius get snackbar => smRadius;

  /// Dropdown border radius: 8px
  static BorderRadius get dropdown => smRadius;

  /// Menu border radius: 12px
  static BorderRadius get menu => mdRadius;
}
