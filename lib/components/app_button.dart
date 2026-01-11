import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

enum AppButtonType { primary, secondary, inactive }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final IconData? icon;
  final String? price;
  final bool isFullWidth;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.price,
    this.isFullWidth = false,
  });

  const AppButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isFullWidth = false,
    this.price,
  }) : type = AppButtonType.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.price,
    this.isFullWidth = false,
  }) : type = AppButtonType.secondary;

  const AppButton.inactive({
    super.key,
    required this.label,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isFullWidth = false,
    this.price,
  })  : type = AppButtonType.inactive,
        onPressed = null;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && type != AppButtonType.inactive;
    final buttonStyle = _getButtonStyle(isEnabled);
    final textStyle = _getTextStyle();
    final padding = _getPadding();
    final height = _getHeight();
    final width = _getWidth();

    Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: _getIconSize(), color: buttonStyle.textColor),
          const SizedBox(width: 8),
        ],
        Text(label, style: textStyle),
        if (price != null) ...[
          const SizedBox(width: 8),
          Text(
            price!,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );

    return SizedBox(
      height: height,
      width: isFullWidth ? double.infinity : width,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonStyle.backgroundColor,
          foregroundColor: buttonStyle.textColor,
          disabledBackgroundColor: buttonStyle.backgroundColor,
          disabledForegroundColor: buttonStyle.textColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12), // Material Design 3 uses 12px
          ),
          elevation: 0, // Flat buttons in Material Design 3
        ),
        child: content,
      ),
    );
  }

  _ButtonStyle _getButtonStyle(bool isEnabled) {
    switch (type) {
      case AppButtonType.primary:
        return _ButtonStyle(
          backgroundColor: AppColors.primary,
          textColor: AppColors.textOnPrimary,
        );
      case AppButtonType.secondary:
        return _ButtonStyle(
          backgroundColor: AppColors.secondary,
          textColor: AppColors.textOnSecondary,
        );
      case AppButtonType.inactive:
        return _ButtonStyle(
          backgroundColor: AppColors.border,
          textColor: AppColors.textSecondary,
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppButtonSize.small:
        return AppTextStyles.labelSmall.copyWith(
          color: _getButtonStyle(true).textColor,
        );
      case AppButtonSize.medium:
        return AppTextStyles.labelMedium.copyWith(
          color: _getButtonStyle(true).textColor,
        );
      case AppButtonSize.large:
        return AppTextStyles.labelLarge.copyWith(
          color: _getButtonStyle(true).textColor,
        );
    }
  }

  EdgeInsets _getPadding() {
    return switch (size) {
      AppButtonSize.small => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    };
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }

  double _getWidth() {
    switch (size) {
      case AppButtonSize.small:
        return 120;
      case AppButtonSize.medium:
        return 220;
      case AppButtonSize.large:
        return 260;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }
}

class _ButtonStyle {
  final Color backgroundColor;
  final Color textColor;

  _ButtonStyle({
    required this.backgroundColor,
    required this.textColor,
  });
}
