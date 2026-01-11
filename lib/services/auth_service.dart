import 'package:adm_panel_v2/network/models/requests/login_request.dart';

import '../core/network/api_response.dart';
import '../core/services/api_service.dart';
import '../network/models/responses/login_response.dart';

class AuthService extends ApiService {
  AuthService(super.apiClient);

  Future<ApiResponse<LoginResponse>> loginWithPassword(String phone, String password) async {
    try {
      final request = LoginRequest(phone: phone, password: password);

      final response = await post<Map<String, dynamic>>(
        '/api/v1/auth/login/',
        data: request.toJson(),
      );

      // Проверяем на ошибки (теперь используем message вместо error)
      if (response.message != null) {
        return ApiResponse.error(response.message!, response.statusCode);
      }

      if (response.data == null) {
        return ApiResponse.error('Пустой ответ от сервера', response.statusCode);
      }

      // Парсим ответ в модель
      final loginResponse = LoginResponse.fromJson(response.data!);
      return ApiResponse.success(loginResponse);
    } catch (e) {
      return ApiResponse.error(
        'Ошибка входа: ${e.toString()}',
        500,
      );
    }
  }

  // Future<ApiResponse<LoginResponse>> requestSMScode(String phone) async {
  //   try {
  //     // Используем базовый метод get из ApiService
  //     final response = await get<Map<String, dynamic>>(
  //       '/users/$userId',
  //     );
  //
  //     if (response.message != null) {
  //       return ApiResponse.error(response.message!);
  //     }
  //
  //     if (response.data == null) {
  //       return ApiResponse.error('Пустой ответ от сервера');
  //     }
  //
  //     // Парсим ответ в модель
  //     final userProfile = LoginResponse.fromJson(response.data!);
  //     return ApiResponse.success(userProfile);
  //   } catch (e) {
  //     return ApiResponse.error('Ошибка получения профиля: ${e.toString()}');
  //   }
  // }
  //
  // Future<ApiResponse<LoginResponse>> loginWithPhoneAndSMS(String phone) async {
  //   try {
  //     // Используем базовый метод get из ApiService
  //     final response = await get<Map<String, dynamic>>(
  //       '/users/$userId',
  //     );
  //
  //     if (response.message != null) {
  //       return ApiResponse.error(response.message!);
  //     }
  //
  //     if (response.data == null) {
  //       return ApiResponse.error('Пустой ответ от сервера');
  //     }
  //
  //     // Парсим ответ в модель
  //     final userProfile = LoginResponse.fromJson(response.data!);
  //     return ApiResponse.success(userProfile);
  //   } catch (e) {
  //     return ApiResponse.error('Ошибка получения профиля: ${e.toString()}');
  //   }
  // }

}