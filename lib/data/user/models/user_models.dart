class UserModel {
  final int id;
  final String login;
  final int role;
  final String roleLabel;
  final String? createdAt;
  final String? updatedAt;

  const UserModel({
    required this.id,
    required this.login,
    required this.role,
    required this.roleLabel,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num).toInt(),
      login: json['login'] as String? ?? '',
      role: (json['role'] as num?)?.toInt() ?? 10,
      roleLabel: json['roleLabel'] as String? ?? 'User',
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class CreateUserRequest {
  final String login;
  final String password;
  final int? role;

  const CreateUserRequest({
    required this.login,
    required this.password,
    this.role,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'login': login,
      'password': password,
    };
    if (role != null) {
      map['role'] = role;
    }
    return map;
  }
}
