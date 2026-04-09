import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

enum AppTextFieldSize {
  regular,
  compact,
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller, // Контроллер значения поля (чтение/запись текста).
    this.labelText, // Подпись поля (label над/внутри input).
    this.hintText, // Подсказка-плейсхолдер при пустом значении.
    this.obscureText = false, // Скрывать ввод (пароль).
    this.enabled = true, // Доступность поля для редактирования.
    this.keyboardType, // Тип клавиатуры (text, number, email и т.д.).
    this.minLines = 1, // Минимальное число строк (для multiline).
    this.maxLines = 1, // Максимальное число строк (1 = single-line).
    this.size = AppTextFieldSize.regular, // Размер компонента: regular/compact.
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final AppTextFieldSize size;

  BorderRadius get _borderRadius => BorderRadius.circular(
        size == AppTextFieldSize.compact ? 8 : 12,
      );

  EdgeInsets get _contentPadding => size == AppTextFieldSize.compact
      ? const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
      : const EdgeInsets.symmetric(horizontal: 14, vertical: 14);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        isDense: true,
        filled: !enabled,
        fillColor: AppColors.surfaceVariant,
        contentPadding: _contentPadding,
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
    );
  }
}
