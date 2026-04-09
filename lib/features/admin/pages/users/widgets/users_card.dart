import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

class UsersCard extends StatelessWidget {
  final String title;
  final Widget child;

  const UsersCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
