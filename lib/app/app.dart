import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/features/home/home_viewmodel.dart';
import 'package:adm_panel_v2/design/app_theme.dart';
import 'package:adm_panel_v2/core/network/api_client.dart';
import 'package:adm_panel_v2/router/app_router.dart';
import '../app/app_config.dart';
import '../services/address_search_service.dart';
import '../router/navigation_service.dart';

import '../services/alert_service.dart';
import '../services/auth_service.dart';
import '../services/basket_service.dart';
import '../services/location_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Storage Service уже зарегистрирован в main.dart

  // Navigation Service (использует routerKey из AppRouter)
  getIt.registerLazySingleton<NavigationService>(
    () => NavigationService(navigatorKey: AppRouter.navigatorKey),
  );

  // Alert Service (использует routerKey из AppRouter)
  getIt.registerLazySingleton<AlertService>(
    () => AlertService()..initialize(navigatorKey: AppRouter.navigatorKey),
  );

  getIt.registerLazySingleton<BasketService>(() => BasketService());

  getIt.registerLazySingleton<LocationService>(() => LocationService());

  // API Client
  // TODO: Замените на ваш реальный baseUrl
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: AppConfig.appBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  // TODO: Зарегистрируйте новые API сервисы здесь
  // Пример:
  // getIt.registerLazySingleton<AuthService>(
  //   () => AuthService(getIt<ApiClient>()),
  // );

  getIt.registerLazySingleton<AuthService>(
      () => AuthService(getIt<ApiClient>()));

  getIt.registerLazySingleton<AddressSearchService>(
    () => AddressSearchService(getIt<ApiClient>()),
  );

  // ViewModels
  getIt.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: AppConfig.showDebugBanner,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
