import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

class AppTabSwitch extends StatelessWidget {
  const AppTabSwitch({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  }) : assert(tabs.length >= 2);

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimaryMuted,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
