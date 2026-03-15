import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/router/app_router.dart';

class AdminSidebar extends StatelessWidget {
  final String currentRoute;

  const AdminSidebar({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: AppColors.surface,
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.dashboard,
                    color: AppColors.textOnPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Admin Panel',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _SidebarItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  route: AppRouter.adminDashboard,
                  isActive: currentRoute == AppRouter.adminDashboard,
                ),
                _SidebarItem(
                  icon: Icons.inventory_2,
                  label: 'Товары',
                  route: AppRouter.adminProducts,
                  isActive: currentRoute.startsWith(AppRouter.adminProducts),
                ),
                _SidebarItem(
                  icon: Icons.category,
                  label: 'Категории',
                  route: AppRouter.adminCategories,
                  isActive: currentRoute.startsWith(AppRouter.adminCategories),
                ),
                _SidebarItem(
                  icon: Icons.receipt_long,
                  label: 'Заказы',
                  route: AppRouter.adminOrders,
                  isActive: currentRoute.startsWith(AppRouter.adminOrders),
                ),
                _SidebarItem(
                  icon: Icons.people,
                  label: 'Пользователи',
                  route: AppRouter.adminUsers,
                  isActive: currentRoute.startsWith(AppRouter.adminUsers),
                ),
                _SidebarItem(
                  icon: Icons.settings,
                  label: 'Настройки',
                  route: AppRouter.adminSettings,
                  isActive: currentRoute == AppRouter.adminSettings,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // User Profile Section
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Администратор',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'admin@example.com',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool isActive;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          size: 22,
        ),
        title: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isActive ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (!isActive) {
            context.go(route);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

