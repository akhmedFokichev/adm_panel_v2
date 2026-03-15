import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:adm_panel_v2/design/mix_styles.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

/// Кнопка с использованием MIX стилей
/// Использует обычные Flutter виджеты для избежания проблем с ограничениями размера
class MixButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Style? style;
  final MixButtonVariant variant;
  final MixButtonSize size;

  const MixButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.variant = MixButtonVariant.primary,
    this.size = MixButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final padding = _getPadding();
    final borderRadius = _getBorderRadius();
    final backgroundColor = _getBackgroundColor();
    final textColor = _getTextColor();
    final border = _getBorder();

    Widget button = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: border,
      ),
      child: Text(
        text,
        style: AppTextStyles.labelLarge.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (onPressed != null) {
      return InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: button,
      );
    }

    return button;
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case MixButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case MixButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
      case MixButtonSize.medium:
      default:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.circular(12);
  }

  Color? _getBackgroundColor() {
    if (variant == MixButtonVariant.text) return null;
    if (variant == MixButtonVariant.outlined) return null;
    return AppColors.primary;
  }

  Color _getTextColor() {
    if (variant == MixButtonVariant.outlined || variant == MixButtonVariant.text) {
      return AppColors.primary;
    }
    return AppColors.textOnPrimary;
  }

  Border? _getBorder() {
    if (variant == MixButtonVariant.outlined) {
      return Border.all(color: AppColors.primary, width: 1.5);
    }
    return null;
  }
}

enum MixButtonVariant {
  primary,
  outlined,
  text,
}

enum MixButtonSize {
  small,
  medium,
  large,
}
