import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

enum AppTagType { default_, primary, secondary }

class AppTag extends StatelessWidget {
  final String label;
  final AppTagType type;
  final IconData? icon;
  final VoidCallback? onTap;

  const AppTag({
    super.key,
    required this.label,
    this.type = AppTagType.default_,
    this.icon,
    this.onTap,
  });

  const AppTag.primary({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  }) : type = AppTagType.primary;

  const AppTag.secondary({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  }) : type = AppTagType.secondary;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: type == AppTagType.primary
              ? Border.all(color: AppColors.primary, width: 1)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: colors.textColor),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _TagColors _getColors() {
    switch (type) {
      case AppTagType.default_:
        return _TagColors(
          backgroundColor: AppColors.border.withOpacity(0.3),
          textColor: AppColors.textPrimary,
        );
      case AppTagType.primary:
        return _TagColors(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          textColor: AppColors.primary,
        );
      case AppTagType.secondary:
        return _TagColors(
          backgroundColor: const Color(0xFFD7CCC8),
          textColor: AppColors.textPrimary,
        );
    }
  }
}

class _TagColors {
  final Color backgroundColor;
  final Color textColor;

  _TagColors({
    required this.backgroundColor,
    required this.textColor,
  });
}


