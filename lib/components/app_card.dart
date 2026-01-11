import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

enum AppCardVariant {
  default_,
  outlined,
  elevated,
  filled,
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AppCardVariant variant;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.variant = AppCardVariant.default_,
    this.borderRadius = 16, // Material Design 3 uses larger radius
    this.backgroundColor,
    this.borderColor,
    this.elevation,
    this.onTap,
    this.width,
    this.height,
  });

  const AppCard.outlined({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.backgroundColor,
    Color? borderColor,
    this.onTap,
    this.width,
    this.height,
  })  : variant = AppCardVariant.outlined,
        elevation = null,
        borderColor = borderColor;

  const AppCard.elevated({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.backgroundColor,
    double? elevation,
    this.onTap,
    this.width,
    this.height,
  })  : variant = AppCardVariant.elevated,
        borderColor = null,
        elevation = elevation;

  const AppCard.filled({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.backgroundColor,
    this.onTap,
    this.width,
    this.height,
  })  : variant = AppCardVariant.filled,
        elevation = null,
        borderColor = null;

  @override
  Widget build(BuildContext context) {
    final cardStyle = _getCardStyle();

    Widget cardContent = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(20), // More padding for Material Design 3
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Default margin
      decoration: BoxDecoration(
        color: backgroundColor ?? cardStyle.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: cardStyle.border,
        boxShadow: cardStyle.boxShadow,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardContent,
      );
    }

    return cardContent;
  }

  _CardStyle _getCardStyle() {
    switch (variant) {
      case AppCardVariant.default_:
        return _CardStyle(
          backgroundColor: AppColors.surface,
          border: Border.all(color: borderColor ?? AppColors.border, width: 1),
          boxShadow: [
            // Material Design 3 subtle shadow
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        );
      case AppCardVariant.outlined:
        return _CardStyle(
          backgroundColor: backgroundColor ?? AppColors.surface,
          border: Border.all(color: borderColor ?? AppColors.border, width: 1),
          boxShadow: null,
        );
      case AppCardVariant.elevated:
        return _CardStyle(
          backgroundColor: backgroundColor ?? AppColors.surface,
          border: null,
          boxShadow: [
            // Material Design 3 card shadow - more pronounced
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: elevation ?? 8,
              offset: Offset(0, (elevation ?? 4) / 2),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: elevation ?? 4,
              offset: const Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        );
      case AppCardVariant.filled:
        return _CardStyle(
          backgroundColor: backgroundColor ?? AppColors.surfaceVariant,
          border: null,
          boxShadow: null,
        );
    }
  }
}

class _CardStyle {
  final Color backgroundColor;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  _CardStyle({
    required this.backgroundColor,
    this.border,
    this.boxShadow,
  });
}

