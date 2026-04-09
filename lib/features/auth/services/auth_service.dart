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
    // В текущем API отдельного endpoint для logout нет.
    // Выход делаем локально через очистку токена/сессии.
    return ApiResponse.success(null);
  }
}
