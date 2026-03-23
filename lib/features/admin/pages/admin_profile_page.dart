import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/features/admin/bloc/admin.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final _userIdController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _avatarController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminUserBloc(),
      child: BlocBuilder<AdminUserBloc, AdminUserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                _ProfileStatusPanel(state: state),
                const SizedBox(height: 16),
                _Card(
                  title: 'Работа с профилем пользователя',
                  child: Column(
                    children: [
                      _Input(
                        controller: _userIdController,
                        label: 'User ID',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      _Input(
                        controller: _firstNameController,
                        label: 'First Name',
                      ),
                      const SizedBox(height: 10),
                      _Input(
                        controller: _lastNameController,
                        label: 'Last Name',
                      ),
                      const SizedBox(height: 10),
                      _Input(
                        controller: _phoneController,
                        label: 'Phone',
                      ),
                      const SizedBox(height: 10),
                      _Input(
                        controller: _avatarController,
                        label: 'Avatar URL',
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    final userId = int.tryParse(
                                      _userIdController.text.trim(),
                                    );
                                    if (userId == null) {
                                      return;
                                    }
                                    context
                                        .read<AdminUserBloc>()
                                        .add(LoadProfileRequested(userId));
                                  },
                            child: const Text('Загрузить'),
                          ),
                          ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    final userId = int.tryParse(
                                      _userIdController.text.trim(),
                                    );
                                    if (userId == null) {
                                      return;
                                    }
                                    context.read<AdminUserBloc>().add(
                                          UpsertProfileRequested(
                                            userId: userId,
                                            firstName: _firstNameController.text,
                                            lastName: _lastNameController.text,
                                            phone: _phoneController.text,
                                            avatarUrl: _avatarController.text,
                                          ),
                                        );
                                  },
                            child: const Text('Сохранить'),
                          ),
                          ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    final userId = int.tryParse(
                                      _userIdController.text.trim(),
                                    );
                                    if (userId == null) {
                                      return;
                                    }
                                    context
                                        .read<AdminUserBloc>()
                                        .add(DeleteProfileRequested(userId));
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                              foregroundColor: AppColors.textOnPrimary,
                            ),
                            child: const Text('Удалить профиль'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileStatusPanel extends StatelessWidget {
  final AdminUserState state;

  const _ProfileStatusPanel({required this.state});

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
        if (state.profile != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Профиль: id=${state.profile!.id}, userId=${state.profile!.userId}, ${state.profile!.firstName ?? ''} ${state.profile!.lastName ?? ''}',
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

class _Input extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;

  const _Input({
    required this.controller,
    required this.label,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
