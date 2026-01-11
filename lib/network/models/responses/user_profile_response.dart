import 'package:adm_panel_v2/network/models/responses/user_model.dart';

/// Ответ с профилем пользователя
class UserProfileResponse {
  final String? message;
  final UserModel? user;

  UserProfileResponse({
    this.message,
    this.user,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      message: json['message'] as String?,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message,
      if (user != null) 'user': user!.toJson(),
    };
  }
}
