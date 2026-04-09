import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/core/bloc/app_bloc_observer.dart';
import 'package:adm_panel_v2/core/di/injection_container.dart';
import 'package:adm_panel_v2/features/splash/splash_page.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем зависимости
  await InjectionContainer().init();

  // Устанавливаем глобальный наблюдатель за BLoC событиями
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel v2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const SplashPage(),
    );
  }
}
