import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adm_panel_v2/features/profile/profile.dart';
import 'package:stacked/stacked.dart';

import '../../components/components.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewmodel>.reactive(
      viewModelBuilder: () => ProfileViewmodel(),
      onViewModelReady: (viewModel) {
        viewModel.initialize();
      },
      builder: (context, viewModel, child) =>
          Scaffold(
            appBar: _buildAppBar(context, viewModel),
            body: _buildBody(context, viewModel),
          ),
    );
  }

  AppAppBar _buildAppBar(BuildContext context, ProfileViewmodel viewModel) {
    return AppAppBar.extended(
        title: 'Профиль',
        automaticallyImplyLeading: false
    );
  }


  Widget _buildBody(BuildContext context, ProfileViewmodel viewModel) {
    return
      Center(
        child:
        Column(
          children: [
            AppButton(
              label: "Мои адреса",
              size: AppButtonSize.medium,
              onPressed: () => viewModel.tapMyAddress(),
            ),
            SizedBox(height: 12),
            AppButton(
              label: "Выйти",
              size: AppButtonSize.medium,
              onPressed: () => viewModel.tapExit(),
            )
          ],
        )
      );
  }
}