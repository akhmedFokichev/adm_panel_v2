import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_data_table.dart';
import 'package:adm_panel_v2/data/user/models/user_models.dart';

class UsersTable extends StatelessWidget {
  final List<UserModel> users;
  final void Function(int userId) onDelete;

  const UsersTable({
    super.key,
    required this.users,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text('Пока нет пользователей. Создайте первого пользователя выше.'),
      );
    }

    return AppDataTable.themed(
      context: context,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: AppDataTable.border,
          columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Login')),
          DataColumn(label: Text('Role')),
          DataColumn(label: Text('Role Label')),
          DataColumn(label: Text('Created At')),
          DataColumn(label: Text('Actions')),
        ],
        rows: users
            .map(
              (user) => DataRow(
                cells: [
                  DataCell(Text('${user.id}')),
                  DataCell(Text(user.login)),
                  DataCell(Text('${user.role}')),
                  DataCell(Text(user.roleLabel)),
                  DataCell(Text(user.createdAt ?? '-')),
                  DataCell(
                    TextButton(
                      onPressed: () => onDelete(user.id),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
        ),
      ),
    );
  }
}
