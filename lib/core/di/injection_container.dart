import 'package:adm_panel_v2/core/network/api_client.dart';
import 'package:adm_panel_v2/core/config/api_config.dart';
import 'package:adm_panel_v2/core/storage/app_storage_service.dart';
import 'package:adm_panel_v2/features/auth/services/auth_service.dart';
import 'package:adm_panel_v2/features/user/services/user_service.dart';

/// Контейнер зависимостей (Dependency Injection)
class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  late final ApiClient _apiClient;
  late final AuthService _authService;
  late final UserService _userService;
  late final AppStorageService _storageService;

  /// Инициализация зависимостей
  Future<void> init({String? baseUrl, String? token}) async {
    _storageService = await AppStorageService.create();
    final persistedToken = token ?? _storageService.getAuthToken();

    _apiClient = ApiClient(
      baseUrl: baseUrl ?? ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      token: persistedToken,
    );

    _authService = AuthService(_apiClient);
    _userService = UserService(_apiClient);
  }

  /// Получить API клиент
  ApiClient get apiClient => _apiClient;

  /// Получить сервис авторизации
  AuthService get authService => _authService;

  /// Получить сервис локального хранилища
  AppStorageService get storageService => _storageService;

  /// Получить сервис пользователей
  UserService get userService => _userService;

  /// Обновить токен авторизации
  void updateAuthToken(String? token) {
    _apiClient.updateToken(token);
  }
}
