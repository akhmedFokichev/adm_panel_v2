import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix/mix.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_bloc.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_state.dart';
import 'package:adm_panel_v2/design/mix_styles.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Форма авторизации
class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;
  final void Function(BuildContext) onLogin;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.loginController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AuthHeader(),
          const SizedBox(height: 32),
          _LoginField(controller: loginController),
          const SizedBox(height: 16),
          _PasswordField(
            controller: passwordController,
            obscureText: obscurePassword,
            onToggleVisibility: onTogglePasswordVisibility,
            onSubmitted: () => onLogin(context),
          ),
          const SizedBox(height: 24),
          _LoginButton(onLogin: () => onLogin(context)),
          const SizedBox(height: 16),
          _AuthHint(),
        ],
      ),
    );
  }
}

/// Заголовок формы авторизации
class _AuthHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: StyledText(
            'Вход в систему',
            style: MixStyles.headingMedium,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: StyledText(
            'Введите логин и пароль',
            style: MixStyles.bodyTextSecondary,
          ),
        ),
      ],
    );
  }
}

/// Поле ввода логина
class _LoginField extends StatelessWidget {
  final TextEditingController controller;

  const _LoginField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Логин',
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите логин';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }
}

/// Поле ввода пароля
class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final VoidCallback onSubmitted;

  const _PasswordField({
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: 'Пароль',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: onToggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите пароль';
        }
        if (value.length < 4) {
          return 'Пароль должен быть не менее 4 символов';
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => onSubmitted(),
    );
  }
}

/// Кнопка входа
class _LoginButton extends StatelessWidget {
  final VoidCallback onLogin;

  const _LoginButton({required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        Widget button = Box(
          style: MixStyles.primaryButton,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.textOnPrimary,
                    ),
                  ),
                )
              : Center(
                  child: StyledText(
                    'Войти',
                    style: MixStyles.primaryButton,
                  ),
                ),
        );

        if (isLoading) {
          button = Opacity(
            opacity: 0.6,
            child: button,
          );
        }

        return Pressable(
          onPress: isLoading ? null : onLogin,
          child: button,
        );
      },
    );
  }
}

/// Подсказка с тестовыми данными
class _AuthHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StyledText(
        'Тестовые данные: admin / admin',
        style: Style(
          $text.style.fontSize(12),
          $text.style.color(AppColors.textSecondary),
        ),
      ),
    );
  }
}
