import 'package:dio/dio.dart';
import 'package:adm_panel_v2/core/network/interceptors/auth_interceptor.dart';

/// HTTP клиент для работы с API
class ApiClient {
  late final Dio dio;

  ApiClient({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Добавляем интерцептор авторизации
    dio.interceptors.add(AuthInterceptor());
  }
}
