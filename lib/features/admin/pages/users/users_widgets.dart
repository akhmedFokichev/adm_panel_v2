import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/data/user/models/user_models.dart';
import 'package:adm_panel_v2/features/admin/pages/users/bloc/users_page_state.dart';

class UsersStatusPanel extends StatelessWidget {
  final UsersPageState state;

  const UsersStatusPanel({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const LinearProgressIndicator();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.error != null)
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.error.withValues(alpha: 0.08),
            child: Text(
              state.error!,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        if (state.successMessage != null)
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.success.withValues(alpha: 0.08),
            child: Text(
              state.successMessage!,
              style: const TextStyle(color: AppColors.success),
            ),
          ),
        if (state.createdUser != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Создан: id=${state.createdUser!.id}, login=${state.createdUser!.login}, role=${state.createdUser!.roleLabel}',
            ),
          ),
      ],
    );
  }
}

class UsersCard extends StatelessWidget {
  final String title;
  final Widget child;

  const UsersCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
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
    );
  }
}

class UsersInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;

  const UsersInput({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
