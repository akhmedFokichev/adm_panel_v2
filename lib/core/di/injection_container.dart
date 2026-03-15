import 'package:adm_panel_v2/core/network/api_client.dart';
import 'package:adm_panel_v2/core/config/api_config.dart';
import 'package:adm_panel_v2/features/auth/services/auth_service.dart';

/// Контейнер зависимостей (Dependency Injection)
class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  late final ApiClient _apiClient;
  late final AuthService _authService;

  /// Инициализация зависимостей
  void init({String? baseUrl, String? token}) {
    _apiClient = ApiClient(
      baseUrl: baseUrl ?? ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      token: token,
    );

    _authService = AuthService(_apiClient);
  }

  /// Получить API клиент
  ApiClient get apiClient => _apiClient;

  /// Получить сервис авторизации
  AuthService get authService => _authService;

  /// Обновить токен авторизации
  void updateAuthToken(String? token) {
    _apiClient.updateToken(token);
  }
}
