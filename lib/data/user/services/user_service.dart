import 'package:adm_panel_v2/core/config/api_config.dart';
import 'package:adm_panel_v2/core/network/api_response.dart';
import 'package:adm_panel_v2/core/network/api_service.dart';
import 'package:adm_panel_v2/data/user/models/profile_models.dart';
import 'package:adm_panel_v2/data/user/models/user_models.dart';

class MeResponse {
  final bool authorized;
  final String message;

  const MeResponse({
    required this.authorized,
    required this.message,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      authorized: json['authorized'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }
}

class UserService extends ApiService {
  UserService(super.apiClient);

  Future<ApiResponse<UserModel>> createUser(CreateUserRequest request) {
    return post<UserModel>(
      ApiConfig.createUser,
      data: request.toJson(),
      fromJson: (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<void>> deleteUser(int userId) {
    return delete<void>('/user/$userId');
  }

  Future<ApiResponse<UserProfileModel>> getProfile(int userId) {
    return get<UserProfileModel>(
      '/user/$userId/profile',
      fromJson: (json) => UserProfileModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<UserProfileModel>> upsertProfile(
    int userId,
    UpsertUserProfileRequest request,
  ) {
    return put<UserProfileModel>(
      '/user/$userId/profile',
      data: request.toJson(),
      fromJson: (json) => UserProfileModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<void>> deleteProfile(int userId) {
    return delete<void>('/user/$userId/profile');
  }

  Future<ApiResponse<MeResponse>> me() {
    return get<MeResponse>(
      ApiConfig.me,
      fromJson: (json) => MeResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
