/// Модель пользователя согласно OpenAPI спецификации
///
/// Ручной парсинг без использования генерации кода
class UserModel {
  final String id;
  final String? name;
  final String? surname;
  final String? email;
  final String? phone;
  final bool? isSuperuser;
  final bool? shouldChangePassword;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    this.name,
    this.surname,
    this.email,
    this.phone,
    this.isSuperuser,
    this.shouldChangePassword,
    this.createdAt,
    this.updatedAt,
  });

  /// Создать из JSON (ручной парсинг)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      isSuperuser: json['is_superuser'] as bool?,
      shouldChangePassword: json['should_change_password'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// Преобразовать в JSON (ручной парсинг)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (isSuperuser != null) 'is_superuser': isSuperuser,
      if (shouldChangePassword != null)
        'should_change_password': shouldChangePassword,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}
