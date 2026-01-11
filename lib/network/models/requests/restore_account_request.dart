/// Запрос на восстановление аккаунта
class RestoreAccountRequest {
  final String phone;
  final String code;

  RestoreAccountRequest({
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


