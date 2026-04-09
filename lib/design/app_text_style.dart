import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

enum AppTextStyle {
  h1,
  h2,
  h3,
  h4,
  bodyLarge,
  body,
  bodySmall,
  caption,
  sidebarLogo,
  sidebarItem,
  topTitle,
  topUser,
  breadcrumb,
  dashboardCardValue,
  dashboardCardSubtitle,
  tableTitle,
  tableHeader,
  tableCell,
}

extension AppTextStyleX on AppTextStyle {
  TextStyle get value {
    switch (this) {
      case AppTextStyle.h1:
        return const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.8,
        );
      case AppTextStyle.h2:
        return const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        );
      case AppTextStyle.h3:
        return const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.4,
        );
      case AppTextStyle.h4:
        return const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.2,
        );
      case AppTextStyle.bodyLarge:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimaryMuted,
        );
      case AppTextStyle.body:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimaryMuted,
        );
      case AppTextStyle.bodySmall:
        return const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        );
      case AppTextStyle.caption:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textTertiary,
        );
      case AppTextStyle.sidebarLogo:
        return const TextStyle(
          color: AppColors.textOnPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 32,
          letterSpacing: -1,
        );
      case AppTextStyle.sidebarItem:
        return const TextStyle(
          color: AppColors.textOnPrimary,
          fontSize: 14,
        );
      case AppTextStyle.topTitle:
        return const TextStyle(
          fontSize: 34,
          color: AppColors.textPrimaryMuted,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.8,
        );
      case AppTextStyle.topUser:
        return const TextStyle(
          color: AppColors.textSecondary,
        );
      case AppTextStyle.breadcrumb:
        return const TextStyle(
          color: AppColors.textTertiary,
          fontSize: 12,
        );
      case AppTextStyle.dashboardCardValue:
        return const TextStyle(
          color: Color(0xFF707070),
          fontSize: 20,
          fontWeight: FontWeight.w300,
        );
      case AppTextStyle.dashboardCardSubtitle:
        return const TextStyle(
          color: AppColors.textTertiary,
          fontSize: 12,
        );
      case AppTextStyle.tableTitle:
        return const TextStyle(
          color: Color(0xFF757575),
          fontSize: 30,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.8,
        );
      case AppTextStyle.tableHeader:
        return const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF7D7D7D),
        );
      case AppTextStyle.tableCell:
        return const TextStyle(
          color: Color(0xFF8B8B8B),
        );
    }
  }
}
