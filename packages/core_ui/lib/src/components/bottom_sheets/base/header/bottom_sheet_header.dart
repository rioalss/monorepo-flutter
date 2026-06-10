import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Header section for bottom sheets with title, optional subtitle, and close.
class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.showCloseButton = false,
    this.showDivider = false,
    this.onClose,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final bool showCloseButton;
  final bool showDivider;
  final VoidCallback? onClose;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tokens = context.colorTokens;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.sm,
            AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          AppTypography.fs18.semibold.color(tokens.onSurface),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle!,
                        style: AppTypography.fs14.regular
                            .color(tokens.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else if (showCloseButton)
                IconButton(
                  icon: const Icon(Icons.close),
                  color: tokens.onSurfaceVariant,
                  onPressed: onClose ?? () => Navigator.of(context).pop(),
                ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: tokens.outlineVariant,
          ),
      ],
    );
  }
}
