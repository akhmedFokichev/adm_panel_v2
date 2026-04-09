/// Модель ответа авторизации
class AuthResponse {
  final int id;
  final String login;
  final int role;
  final String roleLabel;
  final String accessToken;
  final String tokenType;
  final String? expiresAt;
  final String message;
  final UserInfo user;

  AuthResponse({
    required this.id,
    required this.login,
    required this.role,
    required this.roleLabel,
    required this.accessToken,
    required this.tokenType,
    this.expiresAt,
    required this.message,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final userId = json['id'];
    final userLogin = json['login'] as String? ?? '';
    final userRole = json['role'] as int? ?? 10;
    final userRoleLabel = json['roleLabel'] as String? ?? 'User';

    return AuthResponse(
      id: (userId is int) ? userId : int.tryParse('$userId') ?? 0,
      login: userLogin,
      role: userRole,
      roleLabel: userRoleLabel,
      accessToken: json['accessToken'] as String? ?? '',
      tokenType: json['tokenType'] as String? ?? 'Bearer',
      expiresAt: json['expiresAt'] as String?,
      message: json['message'] as String? ?? '',
      user: UserInfo(
        id: '${json['id']}',
        email: userLogin,
        name: userLogin,
        role: userRoleLabel,
      ),
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
