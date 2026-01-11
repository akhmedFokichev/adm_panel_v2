/// Запрос на регистрацию пользователя
class RegisterRequest {
  final String phone;
  final String code;

  RegisterRequest({
    required this.phone,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'code': code,
    };
  }
}


