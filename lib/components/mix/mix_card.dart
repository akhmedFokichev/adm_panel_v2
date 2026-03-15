import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:adm_panel_v2/design/mix_styles.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Карточка с использованием MIX стилей
/// Использует обычные Flutter виджеты для избежания проблем с ограничениями размера
class MixCard extends StatelessWidget {
  final Widget child;
  final Style? style;
  final MixCardVariant variant;
  final VoidCallback? onTap;

  const MixCard({
    super.key,
    required this.child,
    this.style,
    this.variant = MixCardVariant.default_,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: variant == MixCardVariant.default_
            ? Border.all(color: AppColors.border, width: 1)
            : null,
        boxShadow: variant == MixCardVariant.elevated
            ? [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : variant == MixCardVariant.default_
                ? [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: card,
      );
    }

    return card;
  }
}

enum MixCardVariant {
  default_,
  elevated,
}
