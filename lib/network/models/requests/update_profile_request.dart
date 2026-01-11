/// Запрос на обновление профиля пользователя
class UpdateProfileRequest {
  final String? name;
  final String? surname;
  final String? email;

  UpdateProfileRequest({
    this.name,
    this.surname,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      if (email != null) 'email': email,
    };
  }
}


