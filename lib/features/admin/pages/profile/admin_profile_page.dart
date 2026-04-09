import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/bloc/profile_page_bloc.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/bloc/profile_page_event.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/bloc/profile_page_state.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/widgets/profile_card.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/widgets/profile_input.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/widgets/profile_status_panel.dart';

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
      create: (_) => ProfilePageBloc(),
      child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
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
                ProfileStatusPanel(state: state),
                const SizedBox(height: 16),
                ProfileCard(
                  title: 'Работа с профилем пользователя',
                  child: Column(
                    children: [
                      ProfileInput(
                        controller: _userIdController,
                        label: 'User ID',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      ProfileInput(
                        controller: _firstNameController,
                        label: 'First Name',
                      ),
                      const SizedBox(height: 10),
                      ProfileInput(
                        controller: _lastNameController,
                        label: 'Last Name',
                      ),
                      const SizedBox(height: 10),
                      ProfileInput(
                        controller: _phoneController,
                        label: 'Phone',
                      ),
                      const SizedBox(height: 10),
                      ProfileInput(
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
                                        .read<ProfilePageBloc>()
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
                                    context.read<ProfilePageBloc>().add(
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
                                        .read<ProfilePageBloc>()
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
