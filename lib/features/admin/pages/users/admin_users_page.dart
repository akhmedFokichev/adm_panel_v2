import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/features/admin/pages/users/bloc/users_page_bloc.dart';
import 'package:adm_panel_v2/features/admin/pages/users/bloc/users_page_event.dart';
import 'package:adm_panel_v2/features/admin/pages/users/bloc/users_page_state.dart';
import 'package:adm_panel_v2/features/admin/pages/users/widgets/users_card.dart';
import 'package:adm_panel_v2/features/admin/pages/users/widgets/users_input.dart';
import 'package:adm_panel_v2/features/admin/pages/users/widgets/users_status_panel.dart';
import 'package:adm_panel_v2/features/admin/pages/users/widgets/users_table.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController(text: '10');

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
      create: (_) => UsersPageBloc()..add(const LoadUsersRequested()),
      child: BlocBuilder<UsersPageBloc, UsersPageState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Users',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              UsersStatusPanel(state: state),
              const SizedBox(height: 16),
              UsersCard(
                title: 'Добавить пользователя',
                child: Row(
                  children: [
                    Expanded(
                      child: UsersInput(
                        controller: _loginController,
                        label: 'Login',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: UsersInput(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: UsersInput(
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
                              context.read<UsersPageBloc>().add(
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
                child: UsersCard(
                  title: 'Таблица пользователей',
                  child: UsersTable(
                    users: state.users,
                    onDelete: (userId) {
                      context.read<UsersPageBloc>().add(DeleteUserRequested(userId));
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
