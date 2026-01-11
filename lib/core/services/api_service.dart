import 'package:dio/dio.dart';
import 'package:adm_panel_v2/core/network/api_client.dart';
import 'package:adm_panel_v2/core/network/api_response.dart';

/// Базовый класс для API сервисов
abstract class ApiService {
  final ApiClient apiClient;

  ApiService(this.apiClient);

  /// Выполнить GET запрос
  Future<ApiResponse<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await apiClient.dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse.success(
        response.data as T,
        message: response.statusMessage,
      );
    } on DioException catch (e) {
      return _handleError<T>(e, path);
    } catch (e) {
      return ApiResponse.error(
        'Неизвестная ошибка: ${e.toString()}',
        500, // Добавлен statusCode
      );
    }
  }

  /// Выполнить POST запрос
  Future<ApiResponse<T>> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await apiClient.dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse.success(
        response.data as T,
        message: response.statusMessage,
      );

    } on DioException catch (e) {
      return _handleError<T>(e, path);
    } catch (e) {

      return ApiResponse.error(
        'Неизвестная ошибка: ${e.toString()}',
        500, // Добавлен statusCode
      );
    }
  }

  /// Выполнить PUT запрос
  Future<ApiResponse<T>> put<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await apiClient.dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse.success(
        response.data as T,
        message: response.statusMessage,
      );
    } on DioException catch (e) {
      return _handleError<T>(e, path);
    } catch (e) {
      return ApiResponse.error(
        'Неизвестная ошибка: ${e.toString()}',
        500, // Добавлен statusCode
      );
    }
  }

  /// Выполнить DELETE запрос
  Future<ApiResponse<T>> delete<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await apiClient.dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse.success(
        response.data as T,
        message: response.statusMessage,
      );
    } on DioException catch (e) {
      return _handleError<T>(e , path);
    } catch (e) {
      return ApiResponse.error(
        'Неизвестная ошибка: ${e.toString()}',
        500, // Добавлен statusCode
      );
    }
  }

  /// Обработка ошибок Dio
  ApiResponse<T> _handleError<T>(DioException error, String path) {
    String message = 'Ошибка сети';
    int statusCode = 0;

    if (error.response != null) {
      // Сервер вернул ответ с ошибкой
      statusCode = error.response!.statusCode ?? 0;
      message = error.message ?? "неизвестная ошибка";

      final data = error.response!.data;

      if (data is Map<String, dynamic>) {
        message = data['message'] as String? ??
            data['error'] as String? ??
            data['detail'] as String? ??
            'Ошибка сервера';
      } else if (data is String) {
        message = data;
      } else {
        message = 'Ошибка сервера (код: $statusCode)';
      }

      if (statusCode != 200) {
        print("!!!Error>  path>" + path + " code:" + statusCode.toString() + " message> " + message + "  data>" + data.toString());
      }

    } else {
      // Нет ответа от сервера - это проблема сети
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          message = 'Таймаут соединения';
          statusCode = 408;
          break;
        case DioExceptionType.receiveTimeout:
          message = 'Таймаут получения данных';
          statusCode = 408;
          break;
        case DioExceptionType.sendTimeout:
          message = 'Таймаут отправки данных';
          statusCode = 408;
          break;
        case DioExceptionType.connectionError:
          message = 'Ошибка подключения к серверу';
          statusCode = 503;
          break;
        case DioExceptionType.badCertificate:
          message = 'Ошибка сертификата';
          statusCode = 526;
          break;
        case DioExceptionType.cancel:
          message = 'Запрос отменен';
          statusCode = 499;
          break;
        default:
          message = error.message ?? 'Неизвестная ошибка сети';
          statusCode = 500;
      }

      print("!!!Error>  path>" + path + " code:" + statusCode.toString() + " message> " + message);
    }

    return ApiResponse.error(message, statusCode); // Исправлено: добавлен statusCode
  }
}