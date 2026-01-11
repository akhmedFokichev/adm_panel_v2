import '../services/uuid_helper.dart';

/// Модель адреса для результатов поиска
class UserAddress {
  final String id;
  final String address;
  final String? description;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  // Приватный конструктор
  UserAddress._({
    required this.id,
    required this.address,
    this.description,
    this.latitude,
    this.longitude,
    this.isDefault = false,
  });

  // Основной конструктор с автоматической генерацией ID
  factory UserAddress({
    String? id,
    required String address,
    String? description,
    double? latitude,
    double? longitude,
    bool isDefault = false,
  }) {
    return UserAddress._(
      id: id ?? UuidHelper.generate(),
      address: address,
      description: description,
      latitude: latitude,
      longitude: longitude,
      isDefault: isDefault,
    );
  }
}