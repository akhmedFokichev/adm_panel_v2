import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/bloc/profile_page_state.dart';

class ProfileStatusPanel extends StatelessWidget {
  final ProfilePageState state;

  const ProfileStatusPanel({super.key, required this.state});

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
