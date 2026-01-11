import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

class AppProgressBar extends StatelessWidget {
  final double value; // от 0.0 до 1.0
  final double height;
  final Color? color;
  final bool showLabel;
  final String? label;

  const AppProgressBar({
    super.key,
    required this.value,
    this.height = 8,
    this.color,
    this.showLabel = true,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final progressValue = value.clamp(0.0, 1.0);
    final progressColor = color ?? AppColors.primary;
    final percentage = (progressValue * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              label ?? '$percentage%',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.border.withOpacity(0.3),
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progressValue,
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


