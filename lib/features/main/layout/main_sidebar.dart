import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/design/app_images.dart';

/// Модель элемента меню
class SidebarMenuItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;

  const SidebarMenuItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
  });
}

/// Модель группы меню
class SidebarMenuGroup {
  final String? title;
  final List<SidebarMenuItem> items;

  const SidebarMenuGroup({
    this.title,
    required this.items,
  });
}

class MainSidebar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;
  final List<SidebarMenuGroup> menuGroups;

  const MainSidebar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
    List<SidebarMenuGroup>? menuGroups,
  }) : menuGroups = menuGroups ??
            const [
              SidebarMenuGroup(
                items: [
                  SidebarMenuItem(
                    icon: AppIcons.home,
                    activeIcon: AppIcons.homeFilled,
                    label: 'Главная',
                    index: 0,
                  ),
                  SidebarMenuItem(
                    icon: AppIcons.orders,
                    activeIcon: AppIcons.ordersFilled,
                    label: 'Заказы',
                    index: 1,
                  ),
                ],
              ),
              SidebarMenuGroup(
                title: 'Управление',
                items: [
                  SidebarMenuItem(
                    icon: Icons.people,
                    activeIcon: Icons.people,
                    label: 'Пользователи',
                    index: 2,
                  ),
                  SidebarMenuItem(
                    icon: Icons.business,
                    activeIcon: Icons.business,
                    label: 'Клиенты',
                    index: 3,
                  ),
                  SidebarMenuItem(
                    icon: Icons.inventory_2,
                    activeIcon: Icons.inventory_2,
                    label: 'Товары',
                    index: 4,
                  ),
                  SidebarMenuItem(
                    icon: Icons.admin_panel_settings,
                    activeIcon: Icons.admin_panel_settings,
                    label: 'Администраторы',
                    index: 5,
                  ),
                ],
              ),
              SidebarMenuGroup(
                title: 'Система',
                items: [
                  SidebarMenuItem(
                    icon: Icons.palette,
                    activeIcon: Icons.palette,
                    label: 'Дизайн-система',
                    index: 6,
                  ),
                ],
              ),
            ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.black,
      child: Column(
        children: [
          // Logo or Header
          Container(
            height: 56,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    AppIcons.home,
                    color: AppColors.textOnPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'App',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white24,
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: _buildMenuGroups(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuGroups() {
    final List<Widget> widgets = [];

    for (int i = 0; i < menuGroups.length; i++) {
      final group = menuGroups[i];

      // Добавляем разделитель перед группой (кроме первой)
      if (i > 0) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              height: 1,
              color: Colors.white24,
              indent: 16,
              endIndent: 16,
            ),
          ),
        );
      }

      // Добавляем заголовок группы (если есть)
      if (group.title != null) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              group.title!,
              style: AppTextStyles.labelSmall.copyWith(
                color: Colors.white54,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      }

      // Добавляем элементы группы
      for (final item in group.items) {
        widgets.add(
          _SidebarItem(
            icon: item.icon,
            activeIcon: item.activeIcon,
            label: item.label,
            index: item.index,
            isActive: currentIndex == item.index,
            onTap: () => onItemSelected(item.index),
          ),
        );
      }
    }

    return widgets;
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            isActive ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Icon(
          isActive ? activeIcon : icon,
          color: isActive ? AppColors.primary : Colors.white,
          size: 20,
        ),
        title: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isActive ? AppColors.primary : Colors.white,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
