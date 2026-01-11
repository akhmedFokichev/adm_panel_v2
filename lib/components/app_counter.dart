import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

class AppCounter extends StatelessWidget {
  final String label;
  final String? subtitle;
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const AppCounter({
    super.key,
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 999,
  });

  @override
  Widget build(BuildContext context) {
    final canDecrement = value > min;
    final canIncrement = value < max;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.titleMedium,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        Row(
          children: [
            _CounterButton(
              icon: Icons.remove,
              onPressed: canDecrement ? () => onChanged(value - 1) : null,
              isEnabled: canDecrement,
            ),
            const SizedBox(width: 16),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                value.toString(),
                style: AppTextStyles.titleMedium,
              ),
            ),
            const SizedBox(width: 16),
            _CounterButton(
              icon: Icons.add,
              onPressed: canIncrement ? () => onChanged(value + 1) : null,
              isEnabled: canIncrement,
            ),
          ],
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const _CounterButton({
    required this.icon,
    this.onPressed,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.primary : AppColors.border,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            icon,
            size: 18,
            color: isEnabled ? AppColors.textOnPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}


