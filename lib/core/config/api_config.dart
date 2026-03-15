/// Конфигурация API
class ApiConfig {
  ApiConfig._();

  // TODO: Замените на ваш реальный базовый URL
  static const String baseUrl = 'https://api.example.com';
  
  // Endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
