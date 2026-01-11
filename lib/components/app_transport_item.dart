import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/components/app_card.dart';

class AppTransportItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onAdd;
  final bool showAddButton;

  const AppTransportItem({
    super.key,
    required this.label,
    required this.icon,
    this.onAdd,
    this.showAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard.outlined(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.titleMedium,
            ),
          ),
          if (showAddButton && onAdd != null)
            IconButton(
              onPressed: onAdd,
              icon: const Icon(
                Icons.add,
                color: AppColors.primary,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.1),
              ),
            ),
        ],
      ),
    );
  }
}

