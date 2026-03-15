import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/models/user.dart';
import 'package:adm_panel_v2/components/app_card.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  List<User> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
    });

    // Имитация загрузки данных
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _users = User.mockList();
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
                'Пользователи',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Добавить создание пользователя
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Добавить пользователя'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Таблица пользователей
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : AppCard(
                    padding: EdgeInsets.zero,
                    child: _UsersTable(users: _users),
                  ),
          ),
        ],
      ),
    );
  }
}

class _UsersTable extends StatelessWidget {
  final List<User> users;

  const _UsersTable({required this.users});

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
            label: Text('Статус'),
          ),
          DataColumn(
            label: Text('Дата регистрации'),
          ),
          DataColumn(
            label: Text('Действия'),
          ),
        ],
        rows: users.map((user) {
          return DataRow(
            cells: [
              DataCell(Text(user.id)),
              DataCell(
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Text(
                        user.name[0].toUpperCase(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(user.name),
                  ],
                ),
              ),
              DataCell(Text(user.email)),
              DataCell(Text(user.phone ?? '-')),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getRoleColor(user.role).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getRoleLabel(user.role),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: _getRoleColor(user.role),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: user.isActive
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
                          color: user.isActive ? AppColors.success : AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        user.isActive ? 'Активен' : 'Неактивен',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: user.isActive ? AppColors.success : AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DataCell(
                Text(
                  '${user.createdAt.day}.${user.createdAt.month}.${user.createdAt.year}',
                  style: AppTextStyles.bodySmall,
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
                        // TODO: Редактирование пользователя
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      color: AppColors.error,
                      onPressed: () {
                        // TODO: Удаление пользователя
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

  Color _getRoleColor(String role) {
    switch (role) {
      case 'admin':
        return AppColors.error;
      case 'moderator':
        return AppColors.warning;
      default:
        return AppColors.info;
    }
  }

  String _getRoleLabel(String role) {
    switch (role) {
      case 'admin':
        return 'Администратор';
      case 'moderator':
        return 'Модератор';
      default:
        return 'Пользователь';
    }
  }
}
