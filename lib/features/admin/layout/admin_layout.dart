import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/features/admin/layout/admin_sidebar.dart';
import 'package:adm_panel_v2/features/admin/layout/admin_header.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? actions;

  const AdminLayout({
    super.key,
    required this.child,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Sidebar
          AdminSidebar(currentRoute: currentRoute),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Header
                AdminHeader(
                  title: title,
                  actions: actions,
                ),
                // Content
                Expanded(
                  child: Container(
                    color: AppColors.background,
                    child: child,
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
