import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_style.dart';

/// Главный экран админ-панели.
class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _StatsSection(),
          SizedBox(height: 16),
          _TablesSection(),
        ],
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.8,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _StatCard(
          value: '37635 руб.',
          subtitle: 'Получили пользователи',
          color: AppColors.success,
          icon: Icons.shopping_cart_outlined,
        ),
        _StatCard(
          value: '2147895864 руб.',
          subtitle: 'Потратили на кейсы',
          color: AppColors.info,
          icon: Icons.payments_outlined,
        ),
        _StatCard(
          value: '48878',
          subtitle: 'Профит пользователей',
          color: AppColors.error,
          icon: Icons.bar_chart_outlined,
        ),
        _StatCard(
          value: '230',
          subtitle: 'Зарегистрированных пользователей',
          color: AppColors.warning,
          icon: Icons.group_outlined,
        ),
      ],
    );
  }
}

class _TablesSection extends StatelessWidget {
  const _TablesSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _SimpleTableCard(
            title: 'Последние выигрыши',
            columns: ['Название кейса', 'Стоимость'],
            rows: [
              ['milspec', '13'],
              ['milspec', '34'],
              ['milspec', '6'],
              ['milspec', '16'],
              ['revolver', '1148'],
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SimpleTableCard(
            title: 'Последние предметы',
            columns: ['Предмет', 'Имя'],
            rows: [
              ['M4A1-S', 'Золотая спираль'],
              ['USP-S', 'Убийство подтверждено'],
              ['SSG 08', 'Большая пушка'],
              ['AK-47', 'Снежная буря'],
              ['G3SG1', 'Поток'],
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SimpleTableCard(
            title: 'Последние пользователи',
            columns: ['Стим аккаунт', 'Логин'],
            rows: [
              ['76561198283749618', 'CAPTUP.NET'],
              ['76561198283305006', 'Bandik'],
              ['76561198282476078', 'BaBusYA'],
              ['76561198782463326', 'u_Batya'],
              ['76561198282349722', 'andrianovsv112'],
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.dashboardCardValue.value,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.dashboardCardSubtitle.value,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 62,
                  height: 8,
                  color: color,
                ),
              ],
            ),
          ),
          Icon(icon, color: const Color(0xFF989898), size: 40),
        ],
      ),
    );
  }
}

class _SimpleTableCard extends StatelessWidget {
  final String title;
  final List<String> columns;
  final List<List<String>> rows;

  const _SimpleTableCard({
    required this.title,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            height: 44,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Text(
              title,
              style: AppTextStyle.tableTitle.value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Table(
              border: const TableBorder(
                horizontalInside: BorderSide(color: AppColors.divider),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1.4),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: columns
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            item,
                            style: AppTextStyle.tableHeader.value,
                          ),
                        ),
                      )
                      .toList(),
                ),
                ...rows.map(
                  (row) => TableRow(
                    children: row
                        .map(
                          (cell) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              cell,
                              style: AppTextStyle.tableCell.value,
                            ),
                          ),
                        )
                        .toList(),
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
