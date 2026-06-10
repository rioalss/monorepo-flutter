import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart' as shimmer;

/// Themed shimmer overlay for skeleton loading states.
///
/// Wraps [shimmer.Shimmer] with [AppDurations.shimmer] and theme-aware colors.
class AppShimmer extends StatelessWidget {
  const AppShimmer({
    required this.child,
    super.key,
    this.enabled = true,
    this.color,
    this.colorOpacity = 0.12,
    this.duration = AppDurations.shimmer,
    this.direction = const shimmer.ShimmerDirection.fromLTRB(),
  });

  /// Placeholder content shown beneath the shimmer overlay.
  final Widget child;

  /// When false, only [child] is rendered without animation.
  final bool enabled;

  /// Shimmer highlight color. Defaults to [AppColorTokens.onSurface].
  final Color? color;

  /// Opacity of the shimmer overlay (0.0–1.0).
  final double colorOpacity;

  /// Duration of one shimmer sweep.
  final Duration duration;

  /// Direction of the shimmer animation.
  final shimmer.ShimmerDirection direction;

  @override
  Widget build(BuildContext context) {
    final tokens = context.colorTokens;

    return shimmer.Shimmer(
      enabled: enabled,
      color: color ?? tokens.onSurface,
      colorOpacity: colorOpacity,
      duration: duration,
      direction: direction,
      child: child,
    );
  }
}
