class UserProfileModel {
  final int id;
  final int userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatarUrl;
  final String? createdAt;
  final String? updatedAt;

  const UserProfileModel({
    required this.id,
    required this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class UpsertUserProfileRequest {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatarUrl;

  const UpsertUserProfileRequest({
    this.firstName,
    this.lastName,
    this.phone,
    this.avatarUrl,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'avatarUrl': avatarUrl,
      };
}
