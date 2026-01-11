import 'package:uuid/uuid.dart';

class UuidHelper {
  static final _uuid = Uuid();

  /// Генерировать новый UUID v4
  static String generate() => _uuid.v4();

  /// Генерировать UUID v1 (на основе времени)
  static String generateV1() => _uuid.v1();

  /// Генерировать UUID v5 (детерминированный)
  static String generateV5(String namespace, String name) {
    return _uuid.v5(Uuid.NAMESPACE_URL, '$namespace/$name');
  }

  /// Проверить, является ли строка валидным UUID
  static bool isValid(String? value) {
    if (value == null || value.isEmpty) return false;
    final regex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return regex.hasMatch(value);
  }
}