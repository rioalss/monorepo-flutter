import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Footer section for dialog action buttons.
class DialogFooter extends StatelessWidget {
  const DialogFooter({
    super.key,
    this.primaryAction,
    this.secondaryAction,
    this.showDivider = false,
    this.padding,
  });

  final Widget? primaryAction;
  final Widget? secondaryAction;
  final bool showDivider;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    if (primaryAction == null && secondaryAction == null) {
      return const SizedBox.shrink();
    }

    final tokens = context.colorTokens;
    final resolvedPadding = padding ??
        const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: tokens.outlineVariant,
          ),
        Padding(
          padding: resolvedPadding,
          child: Row(
            children: [
              if (secondaryAction != null) ...[
                Expanded(child: secondaryAction!),
                const SizedBox(width: AppSpacing.md),
              ],
              if (primaryAction != null) Expanded(child: primaryAction!),
            ],
          ),
        ),
      ],
    );
  }
}
