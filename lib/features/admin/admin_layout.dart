import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_style.dart';
import 'package:adm_panel_v2/features/admin/pages/admin_dashboard_page.dart';
import 'package:adm_panel_v2/features/admin/pages/design_system/admin_design_system_page.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/admin_profile_page.dart';
import 'package:adm_panel_v2/features/admin/pages/users/admin_users_page.dart';
import 'package:adm_panel_v2/features/admin/bloc/admin.dart';

/// Базовый layout админ-панели: sidebar + topbar + bottombar + контент.
class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminBloc(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundAdmin,
        body: SafeArea(
          child: Row(
            children: [
              Container(
                width: 220,
                color: AppColors.sidebarBackground,
                child: Column(
                  children: [
                    SizedBox(
                      height: 58,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'AdminPanel',
                            style: AppTextStyle.sidebarLogo.value,
                          ),
                        ),
                      ),
                    ),
                    const Divider(color: AppColors.sidebarDivider, height: 1),
                    _SidebarItem(
                      title: 'Главная',
                      icon: Icons.dashboard_outlined,
                      section: AdminSection.home,
                    ),
                    _SidebarItem(
                      title: 'Пользователи',
                      icon: Icons.group_outlined,
                      section: AdminSection.users,
                    ),
                    _SidebarItem(
                      title: 'Профиль',
                      icon: Icons.badge_outlined,
                      section: AdminSection.profile,
                    ),
                    _SidebarItem(
                      title: 'Кейсы',
                      icon: Icons.work_outline,
                      section: AdminSection.cases,
                    ),
                    _SidebarItem(
                      title: 'FAQ',
                      icon: Icons.help_outline,
                      section: AdminSection.faq,
                    ),
                    _SidebarItem(
                      title: 'Предметы',
                      icon: Icons.inventory_2_outlined,
                      section: AdminSection.items,
                    ),
                    _SidebarItem(
                      title: 'Добавить кейсы',
                      icon: Icons.add_box_outlined,
                      section: AdminSection.addCases,
                    ),
                    _SidebarItem(
                      title: 'Дизайн-система',
                      icon: Icons.palette_outlined,
                      section: AdminSection.designSystem,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 56,
                      color: AppColors.surface,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.menu, size: 22),
                          const SizedBox(width: 16),
                          Text(
                            'Административная панель',
                            style: AppTextStyle.topTitle.value,
                          ),
                          const Spacer(),
                          const Icon(Icons.person_outline,
                              size: 18, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(
                            'Admin',
                            style: AppTextStyle.topUser.value,
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: BlocBuilder<AdminBloc, AdminState>(
                          builder: (context, state) {
                            return _contentBySection(state.selectedSection);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 36,
                      color: AppColors.surface,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Сайт / Административная панель',
                        style: AppTextStyle.breadcrumb.value,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentBySection(AdminSection section) {
    switch (section) {
      case AdminSection.home:
        return const AdminDashboardPage();
      case AdminSection.designSystem:
        return const AdminDesignSystemPage();
      case AdminSection.users:
        return const AdminUsersPage();
      case AdminSection.profile:
        return const AdminProfilePage();
      case AdminSection.cases:
        return const _SectionStub(title: 'Кейсы');
      case AdminSection.faq:
        return const _SectionStub(title: 'FAQ');
      case AdminSection.items:
        return const _SectionStub(title: 'Предметы');
      case AdminSection.addCases:
        return const _SectionStub(title: 'Добавить кейсы');
    }
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final AdminSection section;

  const _SidebarItem({
    required this.title,
    required this.icon,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        final isActive = state.selectedSection == section;

        return InkWell(
          onTap: () {
            context.read<AdminBloc>().add(AdminSectionSelected(section));
          },
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.sidebarItemActive
                  : AppColors.transparent,
              border: const Border(
                  bottom: BorderSide(color: AppColors.sidebarDivider)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: AppColors.textOnPrimary, size: 16),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: AppTextStyle.sidebarItem.value,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionStub extends StatelessWidget {
  final String title;

  const _SectionStub({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: AppTextStyle.topTitle.value,
      ),
    );
  }
}
