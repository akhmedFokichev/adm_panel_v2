/// Конфигурация API
class ApiConfig {
  ApiConfig._();

  static const String baseUrl = 'https://identity.xsdk.ru/api/v1';
  static const String mockBearerToken = 'mock-token';

  // Endpoints
  static const String login = '/user/login';
  static const String createUser = '/user';
  static const String me = '/me';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
