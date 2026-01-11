import 'package:adm_panel_v2/network/models/responses/user_model.dart';

/// Ответ на запрос входа в систему
class LoginResponse {
  final String? access;
  final String? refresh;
  final bool? shouldChangePassword;
  final UserModel? user;
  final String? message;

  LoginResponse({
    this.access,
    this.refresh,
    this.shouldChangePassword,
    this.user,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
      shouldChangePassword: json['should_change_password'] as bool?,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (access != null) 'access': access,
      if (refresh != null) 'refresh': refresh,
      if (shouldChangePassword != null)
        'should_change_password': shouldChangePassword,
      if (user != null) 'user': user!.toJson(),
      if (message != null) 'message': message,
    };
  }
}
