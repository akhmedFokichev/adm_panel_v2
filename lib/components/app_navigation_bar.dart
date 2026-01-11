import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

/// Navigation bar item model
class AppNavBarItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final String? badge;

  const AppNavBarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.badge,
  });
}

/// Variants of navigation bars
enum AppNavBarVariant {
  bottomFixed, // Fixed bottom navigation (Material Design 3)
  bottomShifting, // Shifting bottom navigation
  topTabs, // Top tab bar
  pillTabs, // Pill-shaped tabs (segmented control)
}

/// Material Design 3 styled navigation bar component
class AppNavigationBar extends StatelessWidget {
  final List<AppNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final AppNavBarVariant variant;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool showLabels;
  final double? iconSize;
  final double? elevation;
  final TabController? _tabController;

  const AppNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.variant = AppNavBarVariant.bottomFixed,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.iconSize,
    this.elevation,
    TabController? tabController,
  }) : _tabController = tabController;

  /// Bottom fixed navigation bar (Material Design 3 style)
  const AppNavigationBar.bottomFixed({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.iconSize,
    this.elevation,
  })  : variant = AppNavBarVariant.bottomFixed,
        _tabController = null;

  /// Bottom shifting navigation bar
  const AppNavigationBar.bottomShifting({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.iconSize,
    this.elevation,
  })  : variant = AppNavBarVariant.bottomShifting,
        _tabController = null;

  /// Top tab bar (requires TabController from parent)
  const AppNavigationBar.topTabs({
    super.key,
    required this.items,
    required this.currentIndex,
    required TabController tabController,
    this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.iconSize,
    this.elevation,
  })  : variant = AppNavBarVariant.topTabs,
        _tabController = tabController;

  /// Pill-shaped tabs (segmented control)
  const AppNavigationBar.pillTabs({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.iconSize,
    this.elevation,
  })  : variant = AppNavBarVariant.pillTabs,
        _tabController = null;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppNavBarVariant.bottomFixed:
        return _buildBottomFixedNavBar();
      case AppNavBarVariant.bottomShifting:
        return _buildBottomShiftingNavBar();
      case AppNavBarVariant.topTabs:
        return _buildTopTabBar();
      case AppNavBarVariant.pillTabs:
        return _buildPillTabs();
    }
  }

  Widget _buildBottomFixedNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: selectedColor ?? AppColors.primary,
          unselectedItemColor: unselectedColor ?? AppColors.textSecondary,
          backgroundColor: backgroundColor ?? AppColors.surface,
          showSelectedLabels: showLabels,
          showUnselectedLabels: showLabels,
          selectedLabelStyle: AppTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTextStyles.labelSmall,
          iconSize: iconSize ?? 24,
          elevation: elevation ?? 0,
          items: items.map((item) {
            return BottomNavigationBarItem(
              icon: _buildIconWithBadge(
                item.icon,
                item.badge,
                false,
              ),
              activeIcon: _buildIconWithBadge(
                item.activeIcon ?? item.icon,
                item.badge,
                true,
              ),
              label: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBottomShiftingNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: selectedColor ?? AppColors.textOnPrimary,
          unselectedItemColor: unselectedColor ?? AppColors.textOnPrimary,
          backgroundColor: backgroundColor ?? AppColors.primary,
          showSelectedLabels: showLabels,
          showUnselectedLabels: showLabels,
          selectedLabelStyle: AppTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTextStyles.labelSmall,
          iconSize: iconSize ?? 24,
          elevation: elevation ?? 0,
          items: items.map((item) {
            return BottomNavigationBarItem(
              icon: _buildIconWithBadge(
                item.icon,
                item.badge,
                false,
              ),
              activeIcon: _buildIconWithBadge(
                item.activeIcon ?? item.icon,
                item.badge,
                true,
              ),
              label: item.label,
              backgroundColor: backgroundColor ?? AppColors.primary,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTopTabBar() {
    final controller = _tabController;
    if (controller == null) {
      throw StateError(
        'TabController is required for topTabs variant. '
        'Use AppNavigationBar.topTabs(tabController: yourController, ...)',
      );
    }

    return Container(
      color: backgroundColor ?? AppColors.surface,
      child: TabBar(
        controller: controller,
        onTap: onTap,
        labelColor: selectedColor ?? AppColors.primary,
        unselectedLabelColor: unselectedColor ?? AppColors.textSecondary,
        indicatorColor: selectedColor ?? AppColors.primary,
        indicatorWeight: 3,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.labelMedium,
        tabs: items.map((item) {
          if (!showLabels) {
            return Tab(
              icon: _buildIconWithBadge(
                item.icon,
                item.badge,
                false,
              ),
            );
          }
          return Tab(
            text: item.label,
            icon: showLabels
                ? Icon(
                    item.icon,
                    size: iconSize ?? 24,
                  )
                : null,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPillTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: backgroundColor ?? Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          items.length,
          (index) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index < items.length - 1 ? 8 : 0,
              ),
              child: _buildPillTabItem(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPillTabItem(int index) {
    final item = items[index];
    final isSelected = index == currentIndex;
    final backgroundColor = isSelected
        ? (selectedColor ?? AppColors.textPrimary)
        : Colors.transparent;
    final textColor = isSelected
        ? AppColors.textOnPrimary
        : (unselectedColor ?? AppColors.textSecondary);

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap != null ? () => onTap!(index) : null,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected && item.activeIcon != null
                    ? item.activeIcon!
                    : item.icon,
                size: iconSize ?? 18,
                color: textColor,
              ),
              if (showLabels) const SizedBox(width: 8),
              if (showLabels)
                Flexible(
                  child: Text(
                    item.label,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: textColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (item.badge != null && item.badge!.isNotEmpty) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.textOnPrimary.withOpacity(0.2)
                        : AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.badge!,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: textColor,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithBadge(IconData icon, String? badge, bool isActive) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          icon,
          size: iconSize ?? 24,
          color: isActive
              ? (selectedColor ?? AppColors.primary)
              : (unselectedColor ?? AppColors.textSecondary),
        ),
        if (badge != null && badge.isNotEmpty)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  badge,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textOnPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }

}

