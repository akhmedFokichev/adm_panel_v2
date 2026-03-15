/// Модель ответа авторизации
class AuthResponse {
  final String token;
  final String refreshToken;
  final UserInfo user;

  AuthResponse({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String? ?? '',
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

/// Информация о пользователе
class UserInfo {
  final String id;
  final String email;
  final String? name;
  final String? role;

  UserInfo({
    required this.id,
    required this.email,
    this.name,
    this.role,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      role: json['role'] as String?,
    );
  }
}
