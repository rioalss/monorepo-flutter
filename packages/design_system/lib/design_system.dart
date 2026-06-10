/// Shared design tokens for Flutter apps in this monorepo.
///
/// Exports colors, typography, spacing, shape, motion, icons, and theme
/// builders. Import this barrel instead of individual `src/` paths.
library;

// Animations
export 'src/animations/app_curves.dart';
export 'src/animations/app_durations.dart';
// Colors
export 'src/colors/app_color_tokens.dart';
export 'src/colors/app_colors.dart';
export 'src/colors/semantic_colors.dart';
// Icons
export 'src/icons/app_icons.dart';
// Shape
export 'src/shape/app_elevation.dart';
export 'src/shape/app_radius.dart';
// Spacing
export 'src/spacing/app_spacing.dart';
export 'src/spacing/edge_insets.dart';
// Theme
export 'src/theme/app_theme.dart';
export 'src/theme/theme_extensions.dart';
// Typography
export 'src/typography/app_font_scale.dart';
export 'src/typography/app_semantic_typography.dart';
export 'src/typography/app_text_style_builder.dart';
export 'src/typography/app_typography.dart';
