import 'package:dio/dio.dart';
import 'package:adm_panel_v2/core/network/api_client.dart';
import 'package:adm_panel_v2/core/network/api_error_parser.dart';
import 'package:adm_panel_v2/core/network/api_response.dart';

/// Базовый сервис для работы с API
abstract class ApiService {
  final ApiClient apiClient;

  ApiService(this.apiClient);

  bool _isSuccess(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }

  ApiResponse<T> _failureFromResponse<T>(Response<dynamic> response) {
    final details = ApiErrorParser.fromResponse(response);
    return ApiResponse.error(
      details.message,
      details.statusCode,
      details.errorCode,
    );
  }

  ApiResponse<T> _failureFromDio<T>(DioException e) {
    if (e.response != null) {
      return _failureFromResponse<T>(e.response!);
    }
    final details = ApiErrorParser.fromDioException(e);
    return ApiResponse.error(
      details.message,
      details.statusCode,
      details.errorCode,
    );
  }

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

      if (_isSuccess(response.statusCode)) {
        final data =
            fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(data, response.statusCode);
      }
      return _failureFromResponse<T>(response);
    } on DioException catch (e) {
      return _failureFromDio<T>(e);
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

      if (_isSuccess(response.statusCode)) {
        final responseData =
            fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(responseData, response.statusCode);
      }
      return _failureFromResponse<T>(response);
    } on DioException catch (e) {
      return _failureFromDio<T>(e);
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

      if (_isSuccess(response.statusCode)) {
        final responseData =
            fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(responseData, response.statusCode);
      }
      return _failureFromResponse<T>(response);
    } on DioException catch (e) {
      return _failureFromDio<T>(e);
    } catch (e) {
      return ApiResponse.error('Неизвестная ошибка: ${e.toString()}');
    }
  }

  /// Обработка PATCH запроса
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await apiClient.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (_isSuccess(response.statusCode)) {
        final responseData =
            fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(responseData, response.statusCode);
      }
      return _failureFromResponse<T>(response);
    } on DioException catch (e) {
      return _failureFromDio<T>(e);
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

      if (_isSuccess(response.statusCode)) {
        return ApiResponse.success(null as T, response.statusCode);
      }
      return _failureFromResponse<T>(response);
    } on DioException catch (e) {
      return _failureFromDio<T>(e);
    } catch (e) {
      return ApiResponse.error('Неизвестная ошибка: ${e.toString()}');
    }
  }
}
