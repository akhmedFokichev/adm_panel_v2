

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  SecureStorageService._internal();

  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
}


extension on SecureStorageService {
  // ==================== тут описываем все внешние методы ====================



  /// Очистить все данные из безопасного хранилища
  Future<void> clearSecure() async {
    await _secureStorage.deleteAll();
  }
}

extension on SecureStorageService {
  // ==================== Безопасное хранилище (FlutterSecureStorage) ====================
  /// Сохранить строку в безопасном хранилище (для токенов, паролей)
  Future<void> _saveSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Получить строку из безопасного хранилища
  Future<String?> _getSecureString(String key) async {
    return await _secureStorage.read(key: key);
  }

  /// Удалить значение из безопасного хранилища
  Future<void> _removeSecure(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Проверить, существует ли ключ в безопасном хранилище
  Future<bool> _containsSecureKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }

  /// Получить все ключи из безопасного хранилища
  Future<Map<String, String>> _getAllSecureKeys() async {
    return await _secureStorage.readAll();
  }

}