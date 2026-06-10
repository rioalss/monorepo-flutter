import 'package:core_ui/src/components/shimmer/app_shimmer.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Rectangular skeleton placeholder with themed shimmer animation.
///
/// Use for list rows, cards, or text lines while content is loading.
class AppShimmerBox extends StatelessWidget {
  const AppShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.enabled = true,
    this.color,
  });

  /// Box width. Pass [double.infinity] for full-width placeholders.
  final double? width;

  /// Box height.
  final double? height;

  /// Corner radius. Defaults to skeleton radius from the design system.
  final BorderRadius? borderRadius;

  /// When false, renders a static filled box without shimmer.
  final bool enabled;

  /// Background fill color. Defaults to theme surface variant.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tokens = context.colorTokens;

    return AppShimmer(
      enabled: enabled,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? tokens.surfaceVariant,
          borderRadius: borderRadius ?? AppRadius.skeleton,
        ),
      ),
    );
  }
}
