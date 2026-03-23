import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix/mix.dart';
import 'package:adm_panel_v2/features/splash/bloc/splash_bloc.dart';
import 'package:adm_panel_v2/features/splash/bloc/splash_event.dart';
import 'package:adm_panel_v2/features/splash/bloc/splash_state.dart';
import 'package:adm_panel_v2/features/auth/auth_page.dart';
import 'package:adm_panel_v2/features/admin/admin_layout.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Экран загрузки приложения
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(const SplashStarted()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            // Если токен валиден (проверка /me), пропускаем авторизацию.
            if (state is SplashLoaded) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => state.isAuthenticated
                      ? const AdminLayout()
                      : const AuthPage(),
                ),
              );
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Логотип или иконка приложения
                      Box(
                        style: Style(
                          $box.width(120),
                          $box.height(120),
                          $box.borderRadius(24),
                          $box.color(AppColors.textOnPrimary),
                          $box.shadow(
                            color: AppColors.shadowDark,
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ),
                        child: const Icon(
                          Icons.dashboard,
                          size: 64,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Название приложения
                      StyledText(
                        'Admin Panel',
                        style: Style(
                          $text.style.fontSize(32),
                          $text.style.fontWeight(FontWeight.bold),
                          $text.style.color(AppColors.textOnPrimary),
                        ),
                      ),
                      const SizedBox(height: 8),
                      StyledText(
                        'v2.0.0',
                        style: Style(
                          $text.style.fontSize(16),
                          $text.style.color(AppColors.textOnPrimary.withOpacity(0.8)),
                        ),
                      ),
                      const SizedBox(height: 64),
                      // Индикатор загрузки
                      if (state is SplashLoading) ...[
                        SizedBox(
                          width: 200,
                          child: LinearProgressIndicator(
                            value: state.progress,
                            backgroundColor: AppColors.textOnPrimary.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.textOnPrimary,
                            ),
                            minHeight: 4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        StyledText(
                          '${((state.progress ?? 0) * 100).toInt()}%',
                          style: Style(
                            $text.style.fontSize(14),
                            $text.style.color(AppColors.textOnPrimary.withOpacity(0.8)),
                          ),
                        ),
                      ] else if (state is SplashError) ...[
                        StyledText(
                          state.message,
                          style: Style(
                            $text.style.fontSize(14),
                            $text.style.color(AppColors.error),
                          ),
                        ),
                      ] else ...[
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.textOnPrimary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
