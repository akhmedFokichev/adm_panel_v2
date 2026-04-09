import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_bloc.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_event.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_state.dart';
import 'package:adm_panel_v2/features/auth/widgets/auth_widgets.dart';
import 'package:adm_panel_v2/features/admin/admin_layout.dart';
import 'package:adm_panel_v2/design/app_alert_dialog.dart';

/// Экран авторизации
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthLoginRequested(
              login: _loginController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  Future<void> _showAuthError(BuildContext context, AuthError state) async {
    final retry = await AppAlertDialog.showMessage<bool>(
      context,
      title: 'Не удалось войти',
      message: state.message,
      variant: AppAlertDialogVariant.error,
     contentConstraints: const BoxConstraints(
       minWidth: 360,
       maxWidth: 520,
       maxHeight: 380,
     ),
     insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      primaryLabel: 'Повторить',
      secondaryLabel: 'Закрыть',
      primaryResult: true,
      secondaryResult: false,
      onPrimaryPressed: () => debugPrint('нажали Повторить'),
      onSecondaryPressed: () => debugPrint('нажали Закрыть'),
    );
    if (!context.mounted) return;
    if (retry == true) {
      context.read<AuthBloc>().add(
            AuthLoginRequested(
              login: _loginController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AdminLayout(),
              ),
            );
          } else if (state is AuthError) {
            unawaited(_showAuthError(context, state));
          }
        },
        child: Scaffold(
          body: AuthBackground(
            child: SafeArea(
              child: AuthCard(
                child: AuthForm(
                  formKey: _formKey,
                  loginController: _loginController,
                  passwordController: _passwordController,
                  obscurePassword: _obscurePassword,
                  onTogglePasswordVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  onLogin: _handleLogin,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
