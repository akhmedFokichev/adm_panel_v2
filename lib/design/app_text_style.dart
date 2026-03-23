import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

enum AppTextStyle {
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
