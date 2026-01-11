/// Пример модели БЕЗ @JsonSerializable (ручной парсинг)
/// 
/// Это альтернатива UserModel без использования генерации кода.
/// Используйте этот подход, если не хотите использовать build_runner.

class UserModelManual {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? avatar;

  UserModelManual({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.avatar,
  });

  /// Ручной fromJson - создает объект из Map
  factory UserModelManual.fromJson(Map<String, dynamic> json) {
    return UserModelManual(
      id: json['id'] as String,                    // Обязательное поле
      email: json['email'] as String,              // Обязательное поле
      name: json['name'] as String?,               // Опциональное поле
      phone: json['phone'] as String?,             // Опциональное поле
      avatar: json['avatar'] as String?,           // Опциональное поле
    );
  }

  /// Ручной toJson - преобразует объект в Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      // Включаем опциональные поля только если они не null
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (avatar != null) 'avatar': avatar,
    };
  }

  /// Использование в сервисе:
  /// 
  /// ```dart
  /// Future<ApiResponse<List<UserModelManual>>> getUsers() async {
  ///   return get<List<UserModelManual>>(
  ///     '/users',
  ///     fromJson: (json) => (json as List)
  ///         .map((item) => UserModelManual.fromJson(item as Map<String, dynamic>))
  ///         .toList(),
  ///   );
  /// }
  /// ```
}


