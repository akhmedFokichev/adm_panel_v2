import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:adm_panel_v2/design/mix_styles.dart';

/// Альтернативная реализация кнопки с использованием обычных Flutter виджетов
/// и применения стилей MIX через applyMix
class MixButtonAlt extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Style? style;
  final MixButtonVariant variant;
  final MixButtonSize size;

  const MixButtonAlt({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.variant = MixButtonVariant.primary,
    this.size = MixButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    Style baseStyle = _getBaseStyle();
    
    if (size == MixButtonSize.large) {
      baseStyle = baseStyle.add(MixStyles.primaryButtonLarge);
    } else if (size == MixButtonSize.small) {
      baseStyle = baseStyle.add(MixStyles.primaryButtonSmall);
    }

    final finalStyle = style != null ? baseStyle.add(style!) : baseStyle;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Style _getBaseStyle() {
    switch (variant) {
      case MixButtonVariant.primary:
        return MixStyles.primaryButton;
      case MixButtonVariant.outlined:
        return MixStyles.outlinedButton;
      case MixButtonVariant.text:
        return MixStyles.textButton;
    }
  }
}

enum MixButtonVariant {
  primary,
  outlined,
  text,
}

enum MixButtonSize {
  small,
  medium,
  large,
}
