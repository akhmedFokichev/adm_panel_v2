import 'package:dio/dio.dart';

/// Интерцептор для добавления токена авторизации в заголовки
class AuthInterceptor extends Interceptor {
  String? _token;

  AuthInterceptor({String? token}) : _token = token;

  void updateToken(String? token) {
    _token = token;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_token != null) {
      options.headers['Authorization'] = 'Bearer $_token';
    }
    handler.next(options);
  }
}
