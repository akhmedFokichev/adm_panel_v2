import 'package:dio/dio.dart';

/// Интерцептор для добавления токена авторизации в заголовки запросов
class AuthInterceptor extends Interceptor {
  String? _token;

  /// Установить токен авторизации
  void setToken(String token) {
    _token = token;
  }

  /// Очистить токен авторизации
  void clearToken() {
    _token = null;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_token != null) {
      options.headers['Authorization'] = 'Bearer $_token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Если получили 401, возможно токен истек
    if (err.response?.statusCode == 401) {
      _token = null;
    }
    handler.next(err);
  }
}
