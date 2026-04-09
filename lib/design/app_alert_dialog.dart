import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_button.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Тип диалога: иконка и цвет иконки по умолчанию.
enum AppAlertDialogVariant {
  none,
  error,
  info,
  success,
  warning,
}

/// Единый `AlertDialog` приложения.
class AppAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final AppAlertDialogVariant variant;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  /// Ограничивает область [content] (ширина/высота тела диалога).
  ///
  /// Пример: `BoxConstraints(minWidth: 360, maxWidth: 520, maxHeight: 400)`.
  /// Для длинного текста с [maxHeight] оборачивайте текст в [SingleChildScrollView]
  /// (как в [showMessage]).
  final BoxConstraints? contentConstraints;

  /// Отступ диалога от краёв экрана; меньше по горизонтали — шире доступная ширина.
  /// По умолчанию у [AlertDialog] — `EdgeInsets.symmetric(horizontal: 40, vertical: 24)`.
  final EdgeInsets? insetPadding;

  /// Крестик в правом верхнем углу заголовка. Если `false`, закрытие только через [actions]
  /// (и при необходимости настройте [barrierDismissible] в [show]/[showMessage]).
  final bool showCloseButton;

  /// Фон карточки диалога (подложка [AlertDialog]).
  final Color backgroundColor;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.variant = AppAlertDialogVariant.info,
    this.primaryLabel = 'OK',
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.contentConstraints,
    this.insetPadding,
    this.showCloseButton = false,
    this.backgroundColor = AppColors.surface,
  });

  static IconData? _iconFor(AppAlertDialogVariant v) {
    switch (v) {
      case AppAlertDialogVariant.none:
        return null;
      case AppAlertDialogVariant.error:
        return Icons.error_outline;
      case AppAlertDialogVariant.info:
        return Icons.info_outline;
      case AppAlertDialogVariant.success:
        return Icons.check_circle_outline;
      case AppAlertDialogVariant.warning:
        return Icons.warning_amber_outlined;
    }
  }

  static Color? _iconColorFor(AppAlertDialogVariant v) {
    switch (v) {
      case AppAlertDialogVariant.none:
        return null;
      case AppAlertDialogVariant.error:
        return AppColors.error;
      case AppAlertDialogVariant.info:
        return AppColors.info;
      case AppAlertDialogVariant.success:
        return AppColors.success;
      case AppAlertDialogVariant.warning:
        return AppColors.warning;
    }
  }

  /// Показать диалог. Результат: `await` вернёт [primaryResult] или [secondaryResult] из `Navigator.pop`.
  ///
  /// Колбэки [onPrimaryPressed] / [onSecondaryPressed] вызываются **до** закрытия диалога (если заданы).
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget content,
    AppAlertDialogVariant variant = AppAlertDialogVariant.info,
    String primaryLabel = 'OK',
    String? secondaryLabel,
    bool barrierDismissible = true,
    T? primaryResult,
    T? secondaryResult,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    BoxConstraints? contentConstraints,
    EdgeInsets? insetPadding,
    bool showCloseButton = false,
    Color? backgroundColor,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        return AppAlertDialog(
          title: title,
          content: content,
          variant: variant,
          primaryLabel: primaryLabel,
          secondaryLabel: secondaryLabel,
          contentConstraints: contentConstraints,
          insetPadding: insetPadding,
          showCloseButton: showCloseButton,
          backgroundColor: backgroundColor ?? AppColors.surface,
          onPrimary: () {
            onPrimaryPressed?.call();
            Navigator.of(dialogContext).pop<T>(primaryResult);
          },
          onSecondary: secondaryLabel != null
              ? () {
                  onSecondaryPressed?.call();
                  Navigator.of(dialogContext).pop<T>(secondaryResult);
                }
              : null,
        );
      },
    );
  }

  /// Диалог с текстом сообщения (с прокруткой).
  static Future<T?> showMessage<T>(
    BuildContext context, {
    required String title,
    required String message,
    AppAlertDialogVariant variant = AppAlertDialogVariant.info,
    String primaryLabel = 'OK',
    String? secondaryLabel,
    bool barrierDismissible = true,
    T? primaryResult,
    T? secondaryResult,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    BoxConstraints? contentConstraints,
    EdgeInsets? insetPadding,
    bool showCloseButton = false,
    Color? backgroundColor = AppColors.background,
  }) {
    return show<T>(
      context,
      title: title,
      content: SingleChildScrollView(child: Text(message)),
      variant: variant,
      primaryLabel: primaryLabel,
      secondaryLabel: secondaryLabel,
      barrierDismissible: barrierDismissible,
      primaryResult: primaryResult,
      secondaryResult: secondaryResult,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
      contentConstraints: contentConstraints,
      insetPadding: insetPadding,
      showCloseButton: showCloseButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconData = _iconFor(variant);
    final iconColor = _iconColorFor(variant);

    Widget body = content;
    if (contentConstraints != null) {
      body = ConstrainedBox(
        constraints: contentConstraints!,
        child: body,
      );
    }

    final titleWidget = showCloseButton
        ? Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(
                  title,
                  textAlign: iconData == null ? TextAlign.start : TextAlign.center,
                ),
              ),
              Positioned(
                top: -36,
                right: -10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Закрыть',
                  visualDensity: VisualDensity.compact,
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(40, 40),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          )
        : Text(
            title,
            textAlign: iconData == null ? TextAlign.start : TextAlign.center,
          );

    return AlertDialog(
      backgroundColor: backgroundColor,
      insetPadding: insetPadding,
      icon: iconData != null
          ? Icon(iconData, color: iconColor, size: 32)
          : null,
      title: titleWidget,
      titlePadding: showCloseButton
          ? const EdgeInsets.fromLTRB(24, 20, 8, 0)
          : null,
      content: body,
      actions: [
        if (secondaryLabel != null && onSecondary != null)
          AppButton(
            label: secondaryLabel!,
            onPressed: onSecondary,
            variant: AppButtonVariant.text,
            size: AppButtonSize.compact,
          ),
        AppButton(
          label: primaryLabel,
          onPressed: onPrimary ?? () => Navigator.of(context).pop(),
          variant: AppButtonVariant.primary,
          size: AppButtonSize.compact,
        ),
      ],
    );
  }
}
