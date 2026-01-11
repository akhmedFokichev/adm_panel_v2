import 'package:geolocator/geolocator.dart';

/// Модель координат пользователя
class UserLocation {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? altitude;
  final double? speed;
  final DateTime? timestamp;

  const UserLocation({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    this.timestamp,
  });

  @override
  String toString() {
    return 'UserLocation(lat: $latitude, lng: $longitude, accuracy: $accuracy)';
  }
}

/// Сервис для работы с геолокацией пользователя
class LocationService {
  /// Проверяет, включены ли службы геолокации
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Проверяет статус разрешений на геолокацию
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Запрашивает разрешение на геолокацию
  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  /// Проверяет и запрашивает разрешения, если необходимо
  /// Возвращает true, если разрешение предоставлено
  Future<bool> ensurePermission() async {
    // Проверяем, включены ли службы геолокации
    final isEnabled = await isLocationServiceEnabled();
    if (!isEnabled) {
      return false;
    }

    // Проверяем текущий статус разрешений
    LocationPermission permission = await checkPermission();

    if (permission == LocationPermission.denied) {
      // Запрашиваем разрешение
      permission = await requestPermission();
    }

    // Возвращаем true только если разрешение предоставлено
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Получает текущую позицию пользователя
  /// [desiredAccuracy] - желаемая точность (по умолчанию best)
  /// [timeLimit] - максимальное время ожидания (по умолчанию 10 секунд)
  Future<UserLocation?> getCurrentLocation({
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
    Duration timeLimit = const Duration(seconds: 10),
  }) async {
    try {
      // Проверяем и запрашиваем разрешения
      final hasPermission = await ensurePermission();
      if (!hasPermission) {
        return null;
      }

      // Получаем позицию
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: desiredAccuracy,
        timeLimit: timeLimit,
      );

      return UserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        speed: position.speed,
        timestamp: position.timestamp,
      );
    } catch (e) {
      print('❌ Ошибка получения местоположения: $e');
      return null;
    }
  }

  /// Получает последнюю известную позицию (может быть устаревшей)
  Future<UserLocation?> getLastKnownLocation() async {
    try {
      final hasPermission = await ensurePermission();
      if (!hasPermission) {
        return null;
      }

      final position = await Geolocator.getLastKnownPosition();
      if (position == null) {
        return null;
      }

      return UserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        speed: position.speed,
        timestamp: position.timestamp,
      );
    } catch (e) {
      print('❌ Ошибка получения последней известной позиции: $e');
      return null;
    }
  }

  /// Подписывается на обновления местоположения
  /// [onLocationUpdate] - callback, вызываемый при каждом обновлении
  /// [desiredAccuracy] - желаемая точность
  /// [distanceFilter] - минимальное расстояние в метрах для обновления (по умолчанию 10м)
  Stream<UserLocation>? watchPosition({
    required Function(UserLocation) onLocationUpdate,
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
    int distanceFilter = 10,
  }) {
    try {
      return Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: desiredAccuracy,
          distanceFilter: distanceFilter,
        ),
      ).map((position) {
        final location = UserLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          speed: position.speed,
          timestamp: position.timestamp,
        );
        onLocationUpdate(location);
        return location;
      });
    } catch (e) {
      print('❌ Ошибка подписки на обновления местоположения: $e');
      return null;
    }
  }

  /// Вычисляет расстояние между двумя точками в метрах
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Вычисляет расстояние от текущей позиции до указанной точки
  Future<double?> calculateDistanceTo(
    double latitude,
    double longitude,
  ) async {
    final currentLocation = await getCurrentLocation();
    if (currentLocation == null) {
      return null;
    }

    return calculateDistance(
      currentLocation.latitude,
      currentLocation.longitude,
      latitude,
      longitude,
    );
  }
}
