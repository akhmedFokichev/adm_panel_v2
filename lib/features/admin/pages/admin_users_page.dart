import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/features/admin/bloc/admin.dart';
import 'package:adm_panel_v2/features/user/models/user_models.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController(text: '10');
  final List<UserModel> _users = [];

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminUserBloc(),
      child: BlocConsumer<AdminUserBloc, AdminUserState>(
        listener: (context, state) {
          if (state.createdUser != null) {
            setState(() {
              _users.removeWhere((item) => item.id == state.createdUser!.id);
              _users.insert(0, state.createdUser!);
            });
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Users',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              _StatusPanel(state: state),
              const SizedBox(height: 16),
              _Card(
                title: 'Добавить пользователя',
                child: Row(
                  children: [
                    Expanded(
                      child: _Input(
                        controller: _loginController,
                        label: 'Login',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _Input(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: _Input(
                        controller: _roleController,
                        label: 'Role',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              final role = int.tryParse(_roleController.text.trim());
                              context.read<AdminUserBloc>().add(
                                    CreateUserRequested(
                                      login: _loginController.text.trim(),
                                      password: _passwordController.text,
                                      role: role,
                                    ),
                                  );
                            },
                      child: const Text('Создать'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _Card(
                  title: 'Таблица пользователей',
                  child: _UsersTable(
                    users: _users,
                    onDelete: (userId) {
                      context.read<AdminUserBloc>().add(DeleteUserRequested(userId));
                      setState(() {
                        _users.removeWhere((item) => item.id == userId);
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  final AdminUserState state;

  const _StatusPanel({required this.state});

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
            color: AppColors.error.withOpacity(0.08),
            child: Text(
              state.error!,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        if (state.successMessage != null)
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.success.withOpacity(0.08),
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

class _Card extends StatelessWidget {
  final String title;
  final Widget child;

  const _Card({
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

class _UsersTable extends StatelessWidget {
  final List<UserModel> users;
  final void Function(int userId) onDelete;

  const _UsersTable({
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

class _Input extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;

  const _Input({
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
