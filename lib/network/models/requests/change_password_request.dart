/// Запрос на смену пароля
class ChangePasswordRequest {
  final String password;

  ChangePasswordRequest({
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
    };
  }
}
