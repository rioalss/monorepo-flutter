import 'package:core_ui/src/components/bottom_sheets/base/footer/bottom_sheet_footer.dart';
import 'package:core_ui/src/components/bottom_sheets/base/header/bottom_sheet_header.dart';
import 'package:core_ui/src/components/bottom_sheets/base/parent/bottom_sheet_parent.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Confirmation dialog-style bottom sheet with cancel and confirm actions.
class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    super.key,
    this.isDestructive = false,
    this.onConfirm,
    this.onCancel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  /// Shows a confirmation bottom sheet and returns `true` on confirm,
  /// `false` on cancel, or `null` when dismissed.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool isDestructive = false,
    bool isDismissible = true,
  }) =>
      BottomSheetParent.show<bool>(
        context,
        isDismissible: isDismissible,
        child: ConfirmationBottomSheet(
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          isDestructive: isDestructive,
          onConfirm: () => Navigator.of(context).pop(true),
          onCancel: () => Navigator.of(context).pop(false),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final tokens = context.colorTokens;
    final colorScheme = Theme.of(context).colorScheme;

    return BottomSheetParent(
      header: BottomSheetHeader(title: title),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.none,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Text(
          message,
          style: AppTypography.fs14.regular.color(tokens.onSurfaceVariant),
        ),
      ),
      footer: BottomSheetFooter(
        showDivider: true,
        secondaryAction: TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        primaryAction: FilledButton(
          style: isDestructive
              ? FilledButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                )
              : null,
          onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ),
    );
  }
}
