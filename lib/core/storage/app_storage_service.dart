import 'package:shared_preferences/shared_preferences.dart';

/// Локальное хранилище наподобие UserDefaults.
class AppStorageService {
  static const String authTokenKey = 'auth.token';
  static const String refreshTokenKey = 'auth.refresh_token';
  static const String userIdKey = 'user.id';
  static const String userNameKey = 'user.name';
  static const String userThemeModeKey = 'settings.theme_mode';
  static const String notificationsEnabledKey = 'settings.notifications_enabled';

  final SharedPreferences _prefs;

  AppStorageService._(this._prefs);

  static Future<AppStorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AppStorageService._(prefs);
  }

  Future<bool> saveAuthToken(String token) => _prefs.setString(authTokenKey, token);
  String? getAuthToken() => _prefs.getString(authTokenKey);
  Future<bool> clearAuthToken() => _prefs.remove(authTokenKey);

  Future<bool> saveRefreshToken(String token) => _prefs.setString(refreshTokenKey, token);
  String? getRefreshToken() => _prefs.getString(refreshTokenKey);
  Future<bool> clearRefreshToken() => _prefs.remove(refreshTokenKey);

  Future<bool> saveUserId(String userId) => _prefs.setString(userIdKey, userId);
  String? getUserId() => _prefs.getString(userIdKey);

  Future<bool> saveUserName(String userName) => _prefs.setString(userNameKey, userName);
  String? getUserName() => _prefs.getString(userNameKey);

  Future<bool> saveThemeMode(String mode) => _prefs.setString(userThemeModeKey, mode);
  String getThemeMode() => _prefs.getString(userThemeModeKey) ?? 'light';

  Future<bool> setNotificationsEnabled(bool enabled) =>
      _prefs.setBool(notificationsEnabledKey, enabled);
  bool isNotificationsEnabled() => _prefs.getBool(notificationsEnabledKey) ?? true;

  Future<void> clearAuthData() async {
    await _prefs.remove(authTokenKey);
    await _prefs.remove(refreshTokenKey);
    await _prefs.remove(userIdKey);
    await _prefs.remove(userNameKey);
  }
}
