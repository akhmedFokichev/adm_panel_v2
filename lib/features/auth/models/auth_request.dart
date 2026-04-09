/// Модель запроса авторизации
class AuthRequest {
  final String login;
  final String password;

  AuthRequest({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}
