import 'package:mix/mix.dart';
import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Базовые стили MIX для проекта
class MixStyles {
  MixStyles._();

  // Кнопки
  static Style get primaryButton => Style(
        $box.padding(16, 24),
        $box.borderRadius(12),
        $box.color(AppColors.primary),
        $text.style.color(AppColors.textOnPrimary),
        $text.style.fontWeight(FontWeight.w600),
        $text.style.fontSize(14),
      );

  static Style get outlinedButton => Style(
        $box.padding(16, 24),
        $box.borderRadius(12),
        $box.border(
          color: AppColors.primary,
          width: 1.5,
        ),
        $text.style.color(AppColors.primary),
        $text.style.fontWeight(FontWeight.w600),
        $text.style.fontSize(14),
      );

  static Style get textButton => Style(
        $box.padding(16, 8),
        $text.style.color(AppColors.primary),
        $text.style.fontWeight(FontWeight.w500),
        $text.style.fontSize(14),
      );

  // Карточки
  static Style get card => Style(
        $box.padding(20),
        $box.borderRadius(16),
        $box.color(AppColors.surface),
        $box.border(
          color: AppColors.border,
          width: 1,
        ),
        $box.shadow(
          color: AppColors.shadowLight,
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      );

  static Style get cardElevated => Style(
        $box.padding(20),
        $box.borderRadius(16),
        $box.color(AppColors.surface),
        $box.shadow(
          color: AppColors.shadowMedium,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      );

  // Инпуты
  static Style get input => Style(
        $box.padding(16),
        $box.borderRadius(12),
        $box.color(AppColors.surface),
        $box.border(
          color: AppColors.border,
          width: 1,
        ),
        $text.style.color(AppColors.textPrimary),
        $text.style.fontSize(14),
      );

  static Style get inputFocused => Style(
        $box.padding(16),
        $box.borderRadius(12),
        $box.color(AppColors.surface),
        $box.border(
          color: AppColors.primary,
          width: 2,
        ),
        $text.style.color(AppColors.textPrimary),
        $text.style.fontSize(14),
      );

  // Текст
  static Style get headingLarge => Style(
        $text.style.color(AppColors.textPrimary),
        $text.style.fontWeight(FontWeight.w600),
        $text.style.fontSize(32),
      );

  static Style get headingMedium => Style(
        $text.style.color(AppColors.textPrimary),
        $text.style.fontWeight(FontWeight.w600),
        $text.style.fontSize(24),
      );

  static Style get bodyText => Style(
        $text.style.color(AppColors.textPrimary),
        $text.style.fontSize(14),
      );

  static Style get bodyTextSecondary => Style(
        $text.style.color(AppColors.textSecondary),
        $text.style.fontSize(14),
      );

  // Бейджи/Теги
  static Style get badge => Style(
        $box.padding.horizontal(8),
        $box.padding.vertical(4),
        $box.borderRadius(8),
        $box.color(AppColors.primary.withOpacity(0.1)),
        $text.style.color(AppColors.primary),
        $text.style.fontWeight(FontWeight.w600),
        $text.style.fontSize(12),
      );

  static Style get badgeSuccess => Style(
        $box.padding.horizontal(8),
        $box.padding.vertical(4),
        $box.borderRadius(8),
        $box.color(AppColors.success.withOpacity(0.1)),
        $text.style.color(AppColors.success),
        $text.style.fontWeight(FontWeight.w600),
        $text.style.fontSize(12),
      );

  static Style get badgeError => Style(
        $box.padding.horizontal(8),
        $box.padding.vertical(4),
        $box.borderRadius(8),
        $box.color(AppColors.error.withOpacity(0.1)),
        $text.style.color(AppColors.error),
        $text.style.fontWeight(FontWeight.w600),
        $text.style.fontSize(12),
      );

  // Композиция стилей (пример)
  static Style get primaryButtonLarge => primaryButton.add(
        Style(
          $box.padding(20, 32),
          $text.style.fontSize(16),
        ),
      );

  static Style get primaryButtonSmall => primaryButton.add(
        Style(
          $box.padding(12, 16),
          $text.style.fontSize(12),
        ),
      );
}
