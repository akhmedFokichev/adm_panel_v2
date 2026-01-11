import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

/// Pill-shaped button for tabs (Material Design 3 style)
/// Used for segmented controls and tab-like navigation
class AppPillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;
  final IconData? icon;
  final double? width;

  const AppPillButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isSelected = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected
        ? AppColors.textPrimary // Black when selected
        : Colors.transparent;
    final textColor = isSelected
        ? AppColors.textOnPrimary // White when selected
        : AppColors.textSecondary; // Gray when not selected

    return SizedBox(
      width: width,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20), // Pill shape
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 18,
                    color: textColor,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: textColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Group of pill buttons (for tabs/segmented control)
class AppPillButtonGroup extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int>? onSelected;
  final List<IconData>? icons;

  const AppPillButtonGroup({
    super.key,
    required this.labels,
    this.selectedIndex = 0,
    this.onSelected,
    this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        labels.length,
        (index) => Padding(
          padding: EdgeInsets.only(
            right: index < labels.length - 1 ? 8 : 0,
          ),
          child: AppPillButton(
            label: labels[index],
            icon: icons != null && index < icons!.length ? icons![index] : null,
            isSelected: index == selectedIndex,
            onPressed: onSelected != null ? () => onSelected!(index) : null,
          ),
        ),
      ),
    );
  }
}
