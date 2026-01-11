import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

/// Модель лейбла для прокручиваемого списка
class ScrollableLabel {
  final String id;
  final String label;
  final IconData? icon;

  const ScrollableLabel({
    required this.id,
    required this.label,
    this.icon,
  });
}

/// Горизонтально прокручиваемый список выбираемых лейблов
class AppScrollableLabels<T> extends StatelessWidget {
  /// Список лейблов для отображения
  final List<ScrollableLabel> labels;

  /// Выбранные ID лейблов
  final Set<String> selectedIds;

  /// Callback при выборе/снятии выбора лейбла
  final ValueChanged<String>? onLabelTap;

  /// Отступы вокруг списка
  final EdgeInsetsGeometry? padding;

  /// Расстояние между лейблами
  final double spacing;

  /// Разрешить множественный выбор
  /// Если false, работает как радиокнопка - можно выбрать только один элемент
  /// В этом случае родительский компонент должен обрабатывать выбор так,
  /// чтобы в selectedIds был только один ID
  final bool allowMultipleSelection;

  /// Стиль выбранного лейбла
  final LabelStyle selectedStyle;

  /// Стиль невыбранного лейбла
  final LabelStyle unselectedStyle;

  const AppScrollableLabels({
    super.key,
    required this.labels,
    required this.selectedIds,
    this.onLabelTap,
    this.padding,
    this.spacing = 12.0,
    this.allowMultipleSelection = true,
    this.selectedStyle = const LabelStyle(
      backgroundColor: AppColors.primary,
      textColor: AppColors.textOnPrimary,
    ),
    this.unselectedStyle = const LabelStyle(
      backgroundColor: AppColors.surfaceVariant,
      textColor: AppColors.textPrimary,
    ),
  });

  /// Создает компонент с кастомными стилями
  const AppScrollableLabels.custom({
    super.key,
    required this.labels,
    required this.selectedIds,
    this.onLabelTap,
    this.padding,
    this.spacing = 12.0,
    this.allowMultipleSelection = true,
    required this.selectedStyle,
    required this.unselectedStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ...labels.asMap().entries.map((entry) {
            final index = entry.key;
            final label = entry.value;
            final isSelected = selectedIds.contains(label.id);

            return Padding(
              padding: EdgeInsets.only(
                right: index < labels.length - 1 ? spacing : 0,
              ),
              child: _LabelChip(
                label: label,
                isSelected: isSelected,
                selectedStyle: selectedStyle,
                unselectedStyle: unselectedStyle,
                onTap: onLabelTap != null
                    ? () {
                        // В режиме радиокнопки всегда вызываем callback
                        // Логика выбора должна быть в родительском компоненте
                        onLabelTap!(label.id);
                      }
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Внутренний виджет для отдельного лейбла
class _LabelChip extends StatelessWidget {
  final ScrollableLabel label;
  final bool isSelected;
  final LabelStyle selectedStyle;
  final LabelStyle unselectedStyle;
  final VoidCallback? onTap;

  const _LabelChip({
    required this.label,
    required this.isSelected,
    required this.selectedStyle,
    required this.unselectedStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = isSelected ? selectedStyle : unselectedStyle;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 1.5)
              : Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label.icon != null) ...[
              Icon(
                label.icon,
                size: 16,
                color: style.textColor,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label.label,
              style: AppTextStyles.labelMedium.copyWith(
                color: style.textColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Стиль лейбла
class LabelStyle {
  final Color backgroundColor;
  final Color textColor;

  const LabelStyle({
    required this.backgroundColor,
    required this.textColor,
  });
}




