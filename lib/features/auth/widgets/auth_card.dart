import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:adm_panel_v2/design/mix_styles.dart';

/// Карточка формы авторизации
class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Box(
            style: MixStyles.cardElevated,
            child: child,
          ),
        ),
      ),
    );
  }
}
