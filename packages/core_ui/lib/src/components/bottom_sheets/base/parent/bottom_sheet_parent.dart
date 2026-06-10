import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Themed shell for modal bottom sheets with optional header, content, and footer slots.
///
/// Use [BottomSheetParent.show] to present the sheet; wrap sheet content in this
/// widget for consistent surface styling, height cap, and drag handle.
class BottomSheetParent extends StatelessWidget {
  /// At least one of [child], [header], [content], or [footer] must be provided.
  const BottomSheetParent({
    super.key,
    this.header,
    this.content,
    this.footer,
    this.child,
    this.maxHeightFactor = 0.9,
    this.showHandle = true,
  }) : assert(
          child != null || content != null || header != null || footer != null,
          'Provide child or at least one section widget.',
        );

  /// Fully custom body; when set, [header], [content], and [footer] are ignored.
  final Widget? child;
  final Widget? header;

  /// Placed in a [Flexible] so it shrinks when the sheet hits [maxHeightFactor].
  final Widget? content;
  final Widget? footer;

  /// Caps sheet height as a fraction of screen height (0.0–1.0).
  final double maxHeightFactor;

  /// Drag handle pill at the top. Ignored when [child] replaces section layout.
  final bool showHandle;

  /// Presents [child] as a modal bottom sheet and returns its pop result.
  ///
  /// [isScrollControlled] should stay `true` for multi-section layouts so the
  /// sheet can grow beyond half the screen. BackgroundColor is transparent so
  /// [BottomSheetParent] owns the visible surface styling.
  ///
  /// Returns `null` when dismissed without a typed result.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useRootNavigator = false,
    bool isScrollControlled = true,
  }) =>
      showModalBottomSheet<T>(
        context: context,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        useRootNavigator: useRootNavigator,
        backgroundColor: Colors.transparent,
        builder: (context) => child,
      );

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * maxHeightFactor;

    return Material(
      color: context.colorTokens.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheet),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: child ?? _buildSections(context),
      ),
    );
  }

  /// Default column layout: handle → header → scrollable content → footer.
  ///
  /// [content] is wrapped in [Flexible] so long bodies scroll instead of
  /// overflowing when the sheet reaches its height cap.
  Widget _buildSections(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHandle)
            _DragHandle(color: context.colorTokens.outlineVariant),
          if (header != null) header!,
          if (content != null) Flexible(child: content!),
          if (footer != null) footer!,
        ],
      );
}

/// Visual affordance indicating the sheet can be dragged to dismiss.
class _DragHandle extends StatelessWidget {
  const _DragHandle({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: AppSpacing.md,
          bottom: AppSpacing.xs,
        ),
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const SizedBox(width: 32, height: 4),
          ),
        ),
      );
}
