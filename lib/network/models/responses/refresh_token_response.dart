/// Ответ на обновление токена
class RefreshTokenResponse {
  final String? message;
  final String? access;
  final String? refresh;

  RefreshTokenResponse({
    this.message,
    this.access,
    this.refresh,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      message: json['message'] as String?,
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message,
      if (access != null) 'access': access,
      if (refresh != null) 'refresh': refresh,
    };
  }
}


