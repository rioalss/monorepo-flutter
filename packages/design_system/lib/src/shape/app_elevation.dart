/// Material elevation levels and shadow presets.
library;

import 'package:flutter/material.dart';

/// Elevation constants and reusable [BoxShadow] lists.
abstract final class AppElevation {
  /// Flat — no shadow.
  static const double level0 = 0;

  /// Subtle lift (cards at rest).
  static const double level1 = 1;

  /// Raised controls and hover states.
  static const double level2 = 3;

  /// Menus and dropdowns.
  static const double level3 = 6;

  /// Dialogs and modals.
  static const double level4 = 8;

  /// Maximum emphasis (FAB, app bar scroll under).
  static const double level5 = 12;

  // ==================== Box Shadows ====================

  /// Empty shadow list for flat surfaces.
  static const List<BoxShadow> none = [];

  /// Two-layer soft shadow suitable for cards and list tiles.
  static List<BoxShadow> get sm => [
        BoxShadow(
          color: Colors.black.withValues(alpha: .05),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: .03),
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ];
}
