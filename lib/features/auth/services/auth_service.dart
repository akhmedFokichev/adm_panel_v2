import 'package:adm_panel_v2/core/network/api_service.dart';
import 'package:adm_panel_v2/core/network/api_response.dart';
import 'package:adm_panel_v2/core/config/api_config.dart';
import 'package:adm_panel_v2/features/auth/models/auth_request.dart';
import 'package:adm_panel_v2/features/auth/models/auth_response.dart';

/// Сервис для работы с API авторизации
class AuthService extends ApiService {
  AuthService(super.apiClient);

  /// Авторизация пользователя
  Future<ApiResponse<AuthResponse>> login(AuthRequest request) async {
    return post<AuthResponse>(
      ApiConfig.login,
      data: request.toJson(),
      fromJson: (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  /// Выход из системы
  Future<ApiResponse<void>> logout() async {
    return post<void>(
      ApiConfig.logout,
    );
  }

  /// Обновление токена
  Future<ApiResponse<AuthResponse>> refreshToken(String refreshToken) async {
    return post<AuthResponse>(
      ApiConfig.refreshToken,
      data: {'refreshToken': refreshToken},
      fromJson: (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
