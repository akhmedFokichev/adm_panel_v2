import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String label;
  final bool isEnabled;

  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    required this.label,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = isEnabled && onChanged != null;

    return InkWell(
      onTap: isActive ? () => onChanged!(!value) : null,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isActive
                    ? (value ? AppColors.primary : AppColors.border)
                    : AppColors.border.withOpacity(0.5),
                width: 2,
              ),
              color: value
                  ? (isActive ? AppColors.primary : AppColors.textSecondary)
                  : Colors.transparent,
            ),
            child: value
                ? const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


