# Использование StorageService

## Инициализация

Сервис автоматически инициализируется в `main.dart` перед запуском приложения.

## Основные методы

### 1. Простые типы данных

```dart
final storageService = GetIt.instance<StorageService>();

// Сохранить строку
await storageService.saveString('user_name', 'Иван');

// Получить строку
final userName = storageService.getString('user_name');
// или с дефолтным значением
final userName = storageService.getStringOrDefault('user_name', 'Гость');

// Сохранить число
await storageService.saveInt('user_age', 25);
final age = storageService.getInt('user_age');

// Сохранить булево значение
await storageService.saveBool('is_first_launch', false);
final isFirstLaunch = storageService.getBoolOrDefault('is_first_launch', true);

// Сохранить список строк
await storageService.saveStringList('recent_searches', ['Москва', 'СПб']);
final searches = storageService.getStringList('recent_searches');
```

### 2. Сохранение объектов (JSON)

```dart
// Сохранить объект
final user = UserProfile(
  id: '123',
  name: 'Иван',
  email: 'ivan@example.com',
);

await storageService.saveObject(
  'user_profile',
  user,
  (json) => UserProfile.fromJson(json), // fromJson функция
);

// Получить объект
final savedUser = storageService.getObject(
  'user_profile',
  (json) => UserProfile.fromJson(json),
);
```

### 3. Сохранение списка объектов

```dart
final addresses = [
  UserAddress(address: 'Москва, ул. Тверская, 1'),
  UserAddress(address: 'СПб, Невский проспект, 10'),
];

await storageService.saveObjectList(
  'saved_addresses',
  addresses,
  (address) => address.toJson(), // toJson функция
);

// Получить список объектов
final savedAddresses = storageService.getObjectList(
  'saved_addresses',
  (json) => UserAddress.fromJson(json),
);
```

### 4. Безопасное хранилище (для токенов, паролей)

```dart
// Сохранить токен в безопасном хранилище
await storageService.saveSecureString('auth_token', 'your-secret-token');

// Получить токен
final token = await storageService.getSecureString('auth_token');

// Удалить токен
await storageService.removeSecure('auth_token');
```

### 5. Управление данными

```dart
// Проверить существование ключа
if (storageService.containsKey('user_name')) {
  // Ключ существует
}

// Удалить значение
await storageService.remove('user_name');

// Получить все ключи
final allKeys = storageService.getAllKeys();

// Очистить все данные
await storageService.clear();
```

## Пример использования в ViewModel

```dart
class ProfileViewModel extends BaseViewModel {
  final _storageService = GetIt.instance<StorageService>();

  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  Future<void> loadUserProfile() async {
    // Загрузить из хранилища
    _userProfile = _storageService.getObject(
      'user_profile',
      (json) => UserProfile.fromJson(json),
    );
    
    if (_userProfile == null) {
      // Загрузить с сервера
      final response = await _userService.getUserProfile();
      if (response.data != null) {
        _userProfile = response.data;
        // Сохранить локально
        await _storageService.saveObject(
          'user_profile',
          _userProfile!,
          (user) => user.toJson(),
        );
      }
    }
    
    notifyListeners();
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    // Сохранить на сервер
    await _userService.updateProfile(profile);
    
    // Сохранить локально
    await _storageService.saveObject(
      'user_profile',
      profile,
      (user) => user.toJson(),
    );
    
    _userProfile = profile;
    notifyListeners();
  }
}
```

## Пример для сохранения адресов

```dart
class MyAddressesViewModel extends BaseViewModel {
  final _storageService = GetIt.instance<StorageService>();
  static const String _addressesKey = 'saved_addresses';

  List<UserAddress> _myAddresses = [];
  List<UserAddress> get myAddresses => _myAddresses;

  Future<void> initialize() async {
    // Загрузить адреса из хранилища
    _myAddresses = _storageService.getObjectList(
      _addressesKey,
      (json) => UserAddress.fromJson(json),
    ) ?? [];
    
    notifyListeners();
  }

  Future<void> addAddress(UserAddress address) async {
    _myAddresses.add(address);
    
    // Сохранить в хранилище
    await _storageService.saveObjectList(
      _addressesKey,
      _myAddresses,
      (addr) => addr.toJson(),
    );
    
    notifyListeners();
  }

  Future<void> deleteAddress(String addressId) async {
    _myAddresses.removeWhere((addr) => addr.id == addressId);
    
    // Сохранить изменения
    await _storageService.saveObjectList(
      _addressesKey,
      _myAddresses,
      (addr) => addr.toJson(),
    );
    
    notifyListeners();
  }
}
```

## Пример для токенов авторизации

```dart
class AuthService {
  final _storageService = GetIt.instance<StorageService>();
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens(String token, String refreshToken) async {
    // Сохранить в безопасном хранилище
    await _storageService.saveSecureString(_tokenKey, token);
    await _storageService.saveSecureString(_refreshTokenKey, refreshToken);
  }

  Future<String?> getToken() async {
    return await _storageService.getSecureString(_tokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storageService.getSecureString(_refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _storageService.removeSecure(_tokenKey);
    await _storageService.removeSecure(_refreshTokenKey);
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
```

## Важные моменты

1. **Безопасное хранилище** используйте для:
   - Токенов авторизации
   - Паролей
   - Ключей API
   - Других чувствительных данных

2. **Обычное хранилище** используйте для:
   - Настроек пользователя
   - Кэша данных
   - Истории поиска
   - Предпочтений приложения

3. **Данные сохраняются**:
   - После перезапуска приложения ✅
   - После переустановки приложения ✅ (если не очистить данные приложения вручную)

4. **Инициализация**: Сервис автоматически инициализируется в `main.dart`, но можно вызвать `initialize()` вручную при необходимости.


