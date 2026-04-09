import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final switchWidget = Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.textOnPrimary,
      activeTrackColor: AppColors.primary,
      inactiveThumbColor: AppColors.surface,
      inactiveTrackColor: AppColors.border,
    );

    if (label == null) {
      return switchWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label!),
        const SizedBox(width: 8),
        switchWidget,
      ],
    );
  }
}
