import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Вариант оформления кнопки: задаёт цвет обводки (если есть) и радиус скругления.
enum AppButtonVariant {
  /// Заливка [AppColors.primary], без обводки.
  primary,

  /// Прозрачный фон, обводка [borderColor].
  outlined,

  /// Без фона и без обводки, только текст.
  text,
}

extension AppButtonVariantTokens on AppButtonVariant {
  /// `null` — рамка не рисуется.
  Color? get borderColor => switch (this) {
        AppButtonVariant.primary => AppColors.primary,
        AppButtonVariant.outlined => AppColors.primary,
        AppButtonVariant.text => null,
      };

  /// Скругление; [AppButtonSize.compact] — меньший радиус.
  double borderRadius(AppButtonSize size) {
    final compact = size == AppButtonSize.compact;
    return switch (this) {
      AppButtonVariant.primary => compact ? 8 : 12,
      AppButtonVariant.outlined => compact ? 8 : 12,
      AppButtonVariant.text => compact ? 6 : 10,
    };
  }
}

/// Размер кнопки: высота, ширина (минимумы или на всю ширину родителя) и отступы содержимого.
enum AppButtonSize {
  /// Высота 52, мин. ширина 80.
  regular,

  /// Высота 40, мин. ширина 56 — диалоги, плотные панели.
  compact,

  /// На всю ширину родителя (`width: double.infinity`), высота как у [regular].
  expanded,
}

/// Единая кнопка приложения на базе MIX ([Pressable] + [Box]).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.regular,
    this.isLoading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;

  /// Необязательная иконка слева от подписи.
  final Widget? icon;

  Style _mixStyle() {
    final compact = size == AppButtonSize.compact;
    final r = variant.borderRadius(size);

    switch (variant) {
      case AppButtonVariant.primary:
        return Style(
          $box.padding(compact ? 10 : 16, compact ? 16 : 24),
          $box.borderRadius(r),
          $box.color(AppColors.primary),
          $text.style.color(AppColors.textOnPrimary),
          $text.style.fontWeight(FontWeight.w600),
          $text.style.fontSize(14),
        );
      case AppButtonVariant.outlined:
        return Style(
          $box.padding(compact ? 10 : 16, compact ? 16 : 24),
          $box.borderRadius(r),
          $box.border(
            color: variant.borderColor!,
            width: 1.5,
          ),
          $text.style.color(AppColors.primary),
          $text.style.fontWeight(FontWeight.w600),
          $text.style.fontSize(14),
        );
      case AppButtonVariant.text:
        return Style(
          $box.padding(compact ? 8 : 16, compact ? 10 : 8),
          $box.borderRadius(r),
          $text.style.color(AppColors.primary),
          $text.style.fontWeight(FontWeight.w500),
          $text.style.fontSize(14),
        );
    }
  }

  Color get _progressColor {
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.textOnPrimary;
      case AppButtonVariant.outlined:
      case AppButtonVariant.text:
        return AppColors.primary;
    }
  }

  bool get _fillParentWidth => size == AppButtonSize.expanded;

  /// Согласовано с вертикальными отступами в [MixStyles] (текст ~20px + padding).
  double get _height => switch (size) {
        AppButtonSize.regular => 52,
        AppButtonSize.compact => 40,
        AppButtonSize.expanded => 52,
      };

  /// Для [AppButtonSize.expanded] в разметке используется `minWidth: 0`; значение для согласованности с [regular].
  double get _minWidth => switch (size) {
        AppButtonSize.regular => 80,
        AppButtonSize.compact => 56,
        AppButtonSize.expanded => 80,
      };

  double get _spinnerSize => switch (size) {
        AppButtonSize.regular => 20,
        AppButtonSize.compact => 18,
        AppButtonSize.expanded => 20,
      };

  @override
  Widget build(BuildContext context) {
    final mixStyle = _mixStyle();
    final effectiveOnPress = isLoading ? null : onPressed;

    Widget labelChild = StyledText(
      label,
      style: mixStyle,
    );

    if (icon != null && !isLoading) {
      labelChild = Row(
        mainAxisSize: _fillParentWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          SizedBox(
            width: size == AppButtonSize.compact ? 6 : 8,
          ),
          labelChild,
        ],
      );
    }

    Widget content = isLoading
        ? SizedBox(
            width: _spinnerSize,
            height: _spinnerSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_progressColor),
            ),
          )
        : labelChild;

    if (isLoading) {
      content = Opacity(
        opacity: 0.6,
        child: content,
      );
    }

    content = Center(child: content);

    Widget box = Box(
      style: mixStyle,
      child: content,
    );

    return Pressable(
      onPress: effectiveOnPress,
      child: Container(
        height: _height,
        width: _fillParentWidth ? double.infinity : null,
        constraints: BoxConstraints(
          minWidth: _fillParentWidth ? 0 : _minWidth,
        ),
        alignment: Alignment.center,
        child: box,
      ),
    );
  }
}
