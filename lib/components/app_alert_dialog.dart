import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/components/app_button.dart';
import 'package:adm_panel_v2/components/app_card.dart';

enum AppAlertType { success, error, warning, info }

class AppAlertDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final IconData? icon;
  final Color? iconColor;
  final AppAlertType type;

  const AppAlertDialog({
    super.key,
    required this.message,
    this.title,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.icon,
    this.iconColor,
    this.type = AppAlertType.info,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 48,
                color: iconColor ?? _getIconColor(),
              ),
              const SizedBox(height: 16),
            ],
            if (title != null) ...[
              Text(
                title!,
                style: AppTextStyles.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (cancelText != null || confirmText != null)
              Row(
                children: [
                  if (cancelText != null)
                    Expanded(
                      child: AppButton.secondary(
                        label: cancelText!,
                        onPressed: () {
                          onCancel?.call();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  if (cancelText != null && confirmText != null)
                    const SizedBox(width: 12),
                  if (confirmText != null)
                    Expanded(
                      child: AppButton.primary(
                        label: confirmText!,
                        onPressed: () {
                          onConfirm?.call();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor() {
    switch (type) {
      case AppAlertType.success:
        return AppColors.success;
      case AppAlertType.error:
        return AppColors.error;
      case AppAlertType.warning:
        return AppColors.warning;
      case AppAlertType.info:
        return AppColors.info;
    }
  }

  /// Показать диалог подтверждения
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Подтвердить',
    String cancelText = 'Отмена',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppAlertDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop(true);
        },
        onCancel: () {
          onCancel?.call();
          Navigator.of(context).pop(false);
        },
      ),
    );
  }

  /// Показать диалог успеха
  static void showSuccess(
    BuildContext context, {
    required String message,
    String title = 'Успешно',
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AppAlertDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        type: AppAlertType.success,
        icon: Icons.check_circle,
        onConfirm: () {
          onConfirm?.call();
        },
      ),
    );
  }

  /// Показать диалог ошибки
  static void showError(
    BuildContext context, {
    required String message,
    String title = 'Ошибка',
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AppAlertDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        type: AppAlertType.error,
        icon: Icons.error,
        onConfirm: () {
          onConfirm?.call();
        },
      ),
    );
  }

  /// Показать диалог предупреждения
  static void showWarning(
    BuildContext context, {
    required String message,
    String title = 'Предупреждение',
    String confirmText = 'OK',
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) => AppAlertDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        type: AppAlertType.warning,
        icon: Icons.warning,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop();
        },
        onCancel: () {
          onCancel?.call();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// Показать информационный диалог
  static void showInfo(
    BuildContext context, {
    required String message,
    String title = 'Информация',
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AppAlertDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        type: AppAlertType.info,
        icon: Icons.info,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
