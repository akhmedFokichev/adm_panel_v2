import 'package:flutter/material.dart';
import 'package:adm_panel_v2/features/admin/layout/admin_layout.dart';
import 'package:adm_panel_v2/features/admin/dashboard/dashboard_viewmodel.dart';
import 'package:adm_panel_v2/components/admin/app_stat_card.dart';
import 'package:adm_panel_v2/components/admin/app_chart.dart';
import 'package:adm_panel_v2/models/admin/dashboard_stats.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, viewModel, child) {
        return AdminLayout(
          title: 'Dashboard',
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Statistics Cards
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    AppStatCard(
                      title: 'Всего заказов',
                      value: viewModel.stats.totalOrders.toString(),
                      icon: Icons.receipt_long,
                      iconColor: AppColors.primary,
                      changePercent: viewModel.stats.ordersChange,
                      changeLabel: 'за последний месяц',
                    ),
                    AppStatCard(
                      title: 'Товары',
                      value: viewModel.stats.totalProducts.toString(),
                      icon: Icons.inventory_2,
                      iconColor: AppColors.info,
                      changePercent: viewModel.stats.productsChange,
                      changeLabel: 'за последний месяц',
                    ),
                    AppStatCard(
                      title: 'Пользователи',
                      value: viewModel.stats.totalUsers.toString(),
                      icon: Icons.people,
                      iconColor: AppColors.success,
                      changePercent: viewModel.stats.usersChange,
                      changeLabel: 'за последний месяц',
                    ),
                    AppStatCard(
                      title: 'Выручка',
                      value: '${viewModel.stats.totalRevenue.toStringAsFixed(0)} ₽',
                      icon: Icons.attach_money,
                      iconColor: AppColors.warning,
                      changePercent: viewModel.stats.revenueChange,
                      changeLabel: 'за последний месяц',
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Charts Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppChart(
                        chartData: ChartData.mockSales(),
                        height: 300,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: AppChart(
                        chartData: ChartData.mockOrders(),
                        height: 300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Recent Activity Section
                Text(
                  'Последние заказы',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _RecentOrderItem(
                        orderId: '#1234',
                        customer: 'Иван Иванов',
                        amount: 2500,
                        status: 'Доставлен',
                      ),
                      const Divider(),
                      _RecentOrderItem(
                        orderId: '#1235',
                        customer: 'Мария Петрова',
                        amount: 1800,
                        status: 'В обработке',
                      ),
                      const Divider(),
                      _RecentOrderItem(
                        orderId: '#1236',
                        customer: 'Алексей Сидоров',
                        amount: 3200,
                        status: 'Доставляется',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RecentOrderItem extends StatelessWidget {
  final String orderId;
  final String customer;
  final double amount;
  final String status;

  const _RecentOrderItem({
    required this.orderId,
    required this.customer,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  customer,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${amount.toStringAsFixed(0)} ₽',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

