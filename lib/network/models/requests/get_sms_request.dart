/// Тип SMS запроса
enum SmsType {
  sms,
  telegram;

  String get value {
    switch (this) {
      case SmsType.sms:
        return 'sms';
      case SmsType.telegram:
        return 'telegram';
    }
  }
}

/// Запрос на получение SMS кода
class GetSMSRequest {
  final String phone;
  final SmsType type;
  final bool isReset;

  GetSMSRequest({
    required this.phone,
    this.type = SmsType.sms,
    this.isReset = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'type': type.value,
      'isReset': isReset,
    };
  }
}
