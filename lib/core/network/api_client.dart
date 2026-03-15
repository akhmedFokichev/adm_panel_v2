import 'package:dio/dio.dart';
import 'package:adm_panel_v2/core/network/interceptors/auth_interceptor.dart';
import 'package:adm_panel_v2/core/network/interceptors/error_interceptor.dart';
import 'package:adm_panel_v2/core/network/interceptors/logging_interceptor.dart';

/// HTTP клиент для работы с API
class ApiClient {
  late final Dio dio;

  ApiClient({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    String? token,
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

    // Добавляем интерцепторы
    dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(token: token),
      ErrorInterceptor(),
    ]);
  }

  /// Обновить токен авторизации
  void updateToken(String? token) {
    final authInterceptor = dio.interceptors
        .firstWhere((i) => i is AuthInterceptor) as AuthInterceptor;
    authInterceptor.updateToken(token);
  }

  /// GET запрос
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST запрос
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT запрос
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PATCH запрос
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE запрос
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
