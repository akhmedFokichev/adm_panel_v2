/// Модель сессии пользователя
class SessionModel {
  final String id;
  final String ipAddress;
  final String userAgent;
  final DateTime createdAt;
  final DateTime lastActivity;
  final bool isCurrent;

  SessionModel({
    required this.id,
    required this.ipAddress,
    required this.userAgent,
    required this.createdAt,
    required this.lastActivity,
    required this.isCurrent,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as String,
      ipAddress: json['ip_address'] as String,
      userAgent: json['user_agent'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastActivity: DateTime.parse(json['last_activity'] as String),
      isCurrent: json['is_current'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ip_address': ipAddress,
      'user_agent': userAgent,
      'created_at': createdAt.toIso8601String(),
      'last_activity': lastActivity.toIso8601String(),
      'is_current': isCurrent,
    };
  }
}


