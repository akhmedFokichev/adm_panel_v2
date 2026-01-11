
import 'package:flutter/material.dart';
import 'package:adm_panel_v2/features/auth/login_auth/login_auth.dart';
import 'package:stacked/stacked.dart';

import '../../../components/components.dart';

class LoginAuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginAuthViewmodel>.reactive(
      viewModelBuilder: () => LoginAuthViewmodel(),
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

  AppAppBar _buildAppBar(BuildContext context, LoginAuthViewmodel viewModel) {
    return AppAppBar.extended(
        title: 'Вход',
        automaticallyImplyLeading: false
    );
  }

  Widget _buildBody(BuildContext context, LoginAuthViewmodel viewModel) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child:
        Column(
          children: [
            Text("Почта:"),

            TextField(
              controller: viewModel.loginTextController,
              decoration: InputDecoration(
                labelText: 'Текстовое поле',
              ),
            ),

            Text("Пароль:"),

            TextField(
              controller: viewModel.passwordTextController,
              decoration: InputDecoration(
                labelText: 'Текстовое поле',
              ),
            ),

            SizedBox(height: 24),

            AppButton(
              label: "Войти",
              type:  viewModel.isOnLoginButton ? AppButtonType.primary : AppButtonType.inactive,
              size: AppButtonSize.small,
              onPressed: () => viewModel.tapLogin(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildComponentCard(
      {required Widget child, EdgeInsetsGeometry? padding}) {
    return AppCard.outlined(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }
}