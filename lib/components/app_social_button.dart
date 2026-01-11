import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

enum SocialProvider { vk, yandex, google, apple }

class AppSocialButton extends StatelessWidget {
  final SocialProvider provider;
  final VoidCallback? onPressed;
  final double size;

  const AppSocialButton({
    super.key,
    required this.provider,
    this.onPressed,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getProviderColors();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: _getProviderIcon(colors.iconColor),
          ),
        ),
      ),
    );
  }

  Widget _getProviderIcon(Color iconColor) {
    switch (provider) {
      case SocialProvider.vk:
        return Text(
          'VK',
          style: TextStyle(
            color: iconColor,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.35,
          ),
        );
      case SocialProvider.yandex:
        return Container(
          width: size * 0.5,
          height: size * 0.5,
          decoration: BoxDecoration(
            color: iconColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'Я',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size * 0.3,
              ),
            ),
          ),
        );
      case SocialProvider.google:
        return Container(
          width: size * 0.5,
          height: size * 0.5,
          decoration: BoxDecoration(
            color: iconColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'G',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size * 0.3,
              ),
            ),
          ),
        );
      case SocialProvider.apple:
        return Icon(
          Icons.apple,
          color: iconColor,
          size: size * 0.5,
        );
    }
  }

  _ProviderColors _getProviderColors() {
    switch (provider) {
      case SocialProvider.vk:
        return _ProviderColors(
          backgroundColor: const Color(0xFF4C75A3),
          iconColor: Colors.white,
        );
      case SocialProvider.yandex:
        return _ProviderColors(
          backgroundColor: Colors.white,
          iconColor: const Color(0xFFFF0000),
        );
      case SocialProvider.google:
        return _ProviderColors(
          backgroundColor: Colors.white,
          iconColor: const Color(0xFF4285F4),
        );
      case SocialProvider.apple:
        return _ProviderColors(
          backgroundColor: Colors.black,
          iconColor: Colors.white,
        );
    }
  }
}

class _ProviderColors {
  final Color backgroundColor;
  final Color iconColor;

  _ProviderColors({
    required this.backgroundColor,
    required this.iconColor,
  });
}


