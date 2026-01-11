import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

class AppRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String label;
  final bool isEnabled;

  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    required this.label,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final isActive = isEnabled && onChanged != null;

    return InkWell(
      onTap: isActive ? () => onChanged!(value) : null,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? (isSelected ? AppColors.primary : AppColors.border)
                    : AppColors.border.withOpacity(0.5),
                width: 2,
              ),
              color: Colors.transparent,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
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


