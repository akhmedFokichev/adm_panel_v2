import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Сервис для постоянного хранения данных
/// Использует SharedPreferences для обычных данных
/// и FlutterSecureStorage для чувствительных данных (токены, пароли)
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  /// Инициализация сервиса (вызывать перед использованием)
  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Проверить, инициализирован ли сервис
  bool get isInitialized => _prefs != null;
}

extension on StorageService {
  // ==================== тут описываем все внешние методы ====================



  /// Очистить все данные
  Future<bool> clear() async {
    await _ensureInitialized();
    return await _prefs!.clear();
  }
}

extension on StorageService {
  // ==================== Обычное хранилище (SharedPreferences) ====================

  /// Сохранить строку
  Future<bool> _saveString(String key, String value) async {
    await _ensureInitialized();
    return await _prefs!.setString(key, value);
  }

  /// Получить строку
  String? _getString(String key) {
    if (!isInitialized) return null;
    return _prefs!.getString(key);
  }

  /// Сохранить целое число
  Future<bool> _saveInt(String key, int value) async {
    await _ensureInitialized();
    return await _prefs!.setInt(key, value);
  }

  /// Получить целое число
  int? _getInt(String key) {
    if (!isInitialized) return null;
    return _prefs!.getInt(key);
  }

  /// Сохранить число с плавающей точкой
  Future<bool> _saveDouble(String key, double value) async {
    await _ensureInitialized();
    return await _prefs!.setDouble(key, value);
  }

  /// Получить число с плавающей точкой
  double? _getDouble(String key) {
    if (!isInitialized) return null;
    return _prefs!.getDouble(key);
  }

  /// Сохранить булево значение
  Future<bool> _saveBool(String key, bool value) async {
    await _ensureInitialized();
    return await _prefs!.setBool(key, value);
  }

  /// Получить булево значение
  bool? _getBool(String key) {
    if (!isInitialized) return null;
    return _prefs!.getBool(key);
  }

  /// Сохранить список строк
  Future<bool> _saveStringList(String key, List<String> value) async {
    await _ensureInitialized();
    return await _prefs!.setStringList(key, value);
  }

  /// Получить список строк
  List<String>? _getStringList(String key) {
    if (!isInitialized) return null;
    return _prefs!.getStringList(key);
  }

  /// Сохранить объект как JSON
  Future<bool> _saveObject<T>(String key, T object, T Function(Map<String, dynamic>) fromJson) async {
    await _ensureInitialized();
    try {
      final jsonString = jsonEncode(object);
      return await _prefs!.setString(key, jsonString);
    } catch (e) {
      print('❌ Ошибка сохранения объекта: $e');
      return false;
    }
  }

  /// Получить объект из JSON
  T? _getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    if (!isInitialized) return null;
    try {
      final jsonString = _prefs!.getString(key);
      if (jsonString == null) return null;
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(jsonMap);
    } catch (e) {
      print('❌ Ошибка получения объекта: $e');
      return null;
    }
  }

  /// Сохранить список объектов как JSON
  Future<bool> _saveObjectList<T>(
      String key,
      List<T> objects,
      Map<String, dynamic> Function(T) toJson,
      ) async {
    await _ensureInitialized();
    try {
      final jsonList = objects.map((obj) => toJson(obj)).toList();
      final jsonString = jsonEncode(jsonList);
      return await _prefs!.setString(key, jsonString);
    } catch (e) {
      print('❌ Ошибка сохранения списка объектов: $e');
      return false;
    }
  }

  /// Получить список объектов из JSON
  List<T>? _getObjectList<T>(
      String key,
      T Function(Map<String, dynamic>) fromJson,
      ) {
    if (!isInitialized) return null;
    try {
      final jsonString = _prefs!.getString(key);
      if (jsonString == null) return null;
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList.map((json) => fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      print('❌ Ошибка получения списка объектов: $e');
      return null;
    }
  }

  /// Удалить значение по ключу
  Future<bool> _remove(String key) async {
    await _ensureInitialized();
    return await _prefs!.remove(key);
  }

  /// Проверить, существует ли ключ
  bool containsKey(String key) {
    if (!isInitialized) return false;
    return _prefs!.containsKey(key);
  }

  /// Получить все ключи
  Set<String> getAllKeys() {
    if (!isInitialized) return {};
    return _prefs!.getKeys();
  }
}

extension on StorageService {

  // ==================== Вспомогательные методы ====================

  /// Убедиться, что сервис инициализирован
  Future<void> _ensureInitialized() async {
    if (!isInitialized) {
      await initialize();
    }
  }

  /// Получить значение с дефолтным значением
  String _getStringOrDefault(String key, String defaultValue) {
    return _getString(key) ?? defaultValue;
  }

  int _getIntOrDefault(String key, int defaultValue) {
    return _getInt(key) ?? defaultValue;
  }

  double _getDoubleOrDefault(String key, double defaultValue) {
    return _getDouble(key) ?? defaultValue;
  }

  bool _getBoolOrDefault(String key, bool defaultValue) {
    return _getBool(key) ?? defaultValue;
  }

  List<String> _getStringListOrDefault(String key, List<String> defaultValue) {
    return _getStringList(key) ?? defaultValue;
  }

}

