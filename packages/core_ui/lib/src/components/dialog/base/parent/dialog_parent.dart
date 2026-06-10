import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Root layout wrapper for dialogs with header, content, and footer slots.
class DialogParent extends StatelessWidget {
  const DialogParent({
    super.key,
    this.header,
    this.content,
    this.footer,
    this.child,
    this.maxWidth = 400,
  }) : assert(
          child != null ||
              content != null ||
              header != null ||
              footer != null,
          'Provide child or at least one section widget.',
        );

  /// Custom layout; when set, [header], [content], and [footer] are ignored.
  final Widget? child;

  final Widget? header;
  final Widget? content;
  final Widget? footer;

  /// Maximum width of the dialog surface.
  final double maxWidth;

  /// Shows a modal dialog using design-system tokens.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isDismissible = true,
    bool useRootNavigator = false,
  }) =>
      showDialog<T>(
        context: context,
        barrierDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        builder: (context) => child,
      );

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Material(
            color: context.colorTokens.surface,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.modal),
            child: child ?? _buildSections(),
          ),
        ),
      );

  Widget _buildSections() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) header!,
          if (content != null) content!,
          if (footer != null) footer!,
        ],
      );
}
