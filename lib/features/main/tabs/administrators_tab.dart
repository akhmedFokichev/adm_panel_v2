import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/models/user.dart';
import 'package:adm_panel_v2/components/app_card.dart';

class AdministratorsTab extends StatefulWidget {
  const AdministratorsTab({super.key});

  @override
  State<AdministratorsTab> createState() => _AdministratorsTabState();
}

class _AdministratorsTabState extends State<AdministratorsTab> {
  List<User> _administrators = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAdministrators();
  }

  Future<void> _loadAdministrators() async {
    setState(() {
      _isLoading = true;
    });

    // Имитация загрузки данных
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _administrators = User.mockAdministratorsList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок и действия
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Администраторы',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Добавить создание администратора
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Добавить администратора'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Таблица администраторов
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : AppCard(
                    padding: EdgeInsets.zero,
                    child: _AdministratorsTable(administrators: _administrators),
                  ),
          ),
        ],
      ),
    );
  }
}

class _AdministratorsTable extends StatelessWidget {
  final List<User> administrators;

  const _AdministratorsTable({required this.administrators});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(AppColors.surfaceVariant),
        columns: const [
          DataColumn(
            label: Text('ID'),
          ),
          DataColumn(
            label: Text('Имя'),
          ),
          DataColumn(
            label: Text('Email'),
          ),
          DataColumn(
            label: Text('Телефон'),
          ),
          DataColumn(
            label: Text('Роль'),
          ),
          DataColumn(
            label: Text('Права доступа'),
          ),
          DataColumn(
            label: Text('Статус'),
          ),
          DataColumn(
            label: Text('Дата создания'),
          ),
          DataColumn(
            label: Text('Последний вход'),
          ),
          DataColumn(
            label: Text('Действия'),
          ),
        ],
        rows: administrators.map((admin) {
          return DataRow(
            cells: [
              DataCell(Text(admin.id)),
              DataCell(
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      child: Text(
                        admin.name[0].toUpperCase(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(admin.name),
                  ],
                ),
              ),
              DataCell(Text(admin.email)),
              DataCell(Text(admin.phone ?? '-')),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getRoleLabel(admin.role),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataCell(
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: _getPermissions(admin.role).map((permission) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        permission,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.info,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: admin.isActive
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: admin.isActive ? AppColors.success : AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        admin.isActive ? 'Активен' : 'Неактивен',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: admin.isActive ? AppColors.success : AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DataCell(
                Text(
                  '${admin.createdAt.day}.${admin.createdAt.month}.${admin.createdAt.year}',
                  style: AppTextStyles.bodySmall,
                ),
              ),
              DataCell(
                Text(
                  _getLastLogin(admin.id),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      color: AppColors.primary,
                      onPressed: () {
                        // TODO: Редактирование администратора
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.lock_reset, size: 20),
                      color: AppColors.warning,
                      onPressed: () {
                        // TODO: Сброс пароля
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      color: AppColors.error,
                      onPressed: () {
                        // TODO: Удаление администратора
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _getRoleLabel(String role) {
    switch (role) {
      case 'admin':
        return 'Администратор';
      case 'super_admin':
        return 'Супер-админ';
      case 'moderator':
        return 'Модератор';
      default:
        return 'Администратор';
    }
  }

  List<String> _getPermissions(String role) {
    switch (role) {
      case 'super_admin':
        return ['Все права', 'Управление', 'Просмотр'];
      case 'admin':
        return ['Управление', 'Просмотр'];
      case 'moderator':
        return ['Модерация', 'Просмотр'];
      default:
        return ['Просмотр'];
    }
  }

  String _getLastLogin(String id) {
    // Имитация последнего входа
    final daysAgo = id.hashCode % 7;
    if (daysAgo == 0) {
      return 'Сегодня';
    } else if (daysAgo == 1) {
      return 'Вчера';
    } else {
      return '$daysAgo дн. назад';
    }
  }
}
