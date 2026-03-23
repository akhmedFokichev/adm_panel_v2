import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Градиентный фон для экрана авторизации
class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.background,
          ],
        ),
      ),
      child: child,
    );
  }
}
