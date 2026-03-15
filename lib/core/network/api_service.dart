import 'package:dio/dio.dart';
import 'package:adm_panel_v2/core/network/api_client.dart';
import 'package:adm_panel_v2/core/network/api_response.dart';
import 'package:adm_panel_v2/core/network/api_exception.dart';

/// Базовый сервис для работы с API
abstract class ApiService {
  final ApiClient apiClient;

  ApiService(this.apiClient);

  /// Обработка GET запроса
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await apiClient.get(
        path,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final data = fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(data, response.statusCode);
      } else {
        return ApiResponse.error(
          'Ошибка запроса: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.error?.toString() ?? 'Ошибка сети',
        e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Неизвестная ошибка: ${e.toString()}');
    }
  }

  /// Обработка POST запроса
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await apiClient.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final responseData = fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(responseData, response.statusCode);
      } else {
        return ApiResponse.error(
          'Ошибка запроса: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.error?.toString() ?? 'Ошибка сети',
        e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Неизвестная ошибка: ${e.toString()}');
    }
  }

  /// Обработка PUT запроса
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await apiClient.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final responseData = fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(responseData, response.statusCode);
      } else {
        return ApiResponse.error(
          'Ошибка запроса: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.error?.toString() ?? 'Ошибка сети',
        e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Неизвестная ошибка: ${e.toString()}');
    }
  }

  /// Обработка DELETE запроса
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await apiClient.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ApiResponse.success(null as T, response.statusCode);
      } else {
        return ApiResponse.error(
          'Ошибка запроса: ${response.statusCode}',
          response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.error?.toString() ?? 'Ошибка сети',
        e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Неизвестная ошибка: ${e.toString()}');
    }
  }
}
