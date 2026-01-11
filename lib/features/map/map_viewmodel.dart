import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

// Класс для хранения результатов поиска
class MapSearchResult {
  final String title;
  final String subtitle;
  final Point? point;

  MapSearchResult({
    required this.title,
    required this.subtitle,
    this.point,
  });
}

class MapViewModel extends BaseViewModel {
  // Контроллер карты
  YandexMapController? _mapController;

  YandexMapController get mapController {
    if (_mapController == null) {
      throw StateError(
          'MapController is not initialized. Call initMapController first.');
    }
    return _mapController!;
  }

  bool get isMapControllerInitialized => _mapController != null;

  // Начальная позиция (Санкт-Петербург)
  final Point _initialPoint = const Point(
    latitude: 43.486475,
    longitude: 43.606324,
  );

  Point get initialPoint => _initialPoint;

  // Текущая позиция камеры
  Point _currentCameraPosition = const Point(
    latitude: 43.486475,
    longitude: 43.606324,
  );

  Point get currentCameraPosition => _currentCameraPosition;

  // Маркеры на карте
  final List<PlacemarkMapObject> _placemarks = [];
  List<PlacemarkMapObject> get placemarks => _placemarks;

  // Зум карты
  double _zoom = 15.0;
  double get zoom => _zoom;

  // Тип карты
  MapType _mapType = MapType.map;
  MapType get mapType => _mapType;

  Future<void> initMapController(YandexMapController controller) async {
    // Если контроллер уже инициализирован, не переинициализируем
    if (_mapController != null && _mapController == controller) {
      print('🗺️ Контроллер уже инициализирован, пропускаем...');
      return;
    }

    print('🗺️ Инициализация контроллера карты...');
    _mapController = controller;

    // Даем карте время на инициализацию
    await Future.delayed(const Duration(milliseconds: 500));

    // Устанавливаем начальную позицию камеры
    try {
      print(
          '🗺️ Установка начальной позиции: ${_initialPoint.latitude}, ${_initialPoint.longitude}, zoom: $_zoom');

      await _mapController!.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _initialPoint,
            zoom: _zoom,
          ),
        ),
        animation: const MapAnimation(
          type: MapAnimationType.linear,
          duration: 0.0,
        ),
      );

      _currentCameraPosition = _initialPoint;
      print('✅ Позиция камеры установлена');

      // Получаем текущую позицию для проверки
      try {
        final currentPos = await _mapController!.getCameraPosition();
        print(
            '📍 Текущая позиция камеры: ${currentPos.target.latitude}, ${currentPos.target.longitude}, zoom: ${currentPos.zoom}');
        print('📍 Тип карты: $_mapType');
        print('📍 Количество маркеров: ${_placemarks.length}');
      } catch (e) {
        print('⚠️ Не удалось получить позицию камеры: $e');
      }

      // Задержка перед добавлением маркера
      await Future.delayed(const Duration(milliseconds: 300));

      // Добавляем начальный маркер
      _addInitialPlacemark();
      print('✅ Маркер добавлен. Всего маркеров: ${_placemarks.length}');

      // Не вызываем notifyListeners() здесь, чтобы избежать пересоздания виджета карты
      // notifyListeners() будет вызван только при изменении маркеров или других данных
      print('✅ Инициализация карты завершена успешно');
    } catch (e, stackTrace) {
      print('❌ Ошибка инициализации карты: $e');
      print('Stack trace: $stackTrace');

      // Пробуем еще раз через задержку
      await Future.delayed(const Duration(milliseconds: 1000));
      try {
        print('🔄 Повторная попытка установки позиции...');
        await _mapController!.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _initialPoint,
              zoom: _zoom,
            ),
          ),
        );
        _currentCameraPosition = _initialPoint;
        _addInitialPlacemark();
        notifyListeners();
        print('✅ Повторная попытка успешна');
      } catch (e2) {
        print('❌ Повторная ошибка инициализации карты: $e2');
      }
    }
  }

  // Добавить начальный маркер
  void _addInitialPlacemark() {
    // Проверяем, не добавлен ли уже маркер
    if (_placemarks.any((p) => p.mapId.value == 'initial_placemark')) {
      print('⚠️ Начальный маркер уже добавлен, пропускаем...');
      return;
    }

    // Используем стандартный маркер Yandex MapKit без кастомной иконки
    final placemark = PlacemarkMapObject(
      mapId: const MapObjectId('initial_placemark'),
      point: _initialPoint,
      text: const PlacemarkText(
        text: 'Санкт-Петербург',
        style: PlacemarkTextStyle(
          size: 12.0,
          color: Color(0xFF000000),
          placement: TextStylePlacement.bottom,
        ),
      ),
    );
    _placemarks.add(placemark);
    notifyListeners();
  }

  // Добавить маркер на карту
  void addPlacemark(Point point, {String? label}) {
    final placemark = PlacemarkMapObject(
      mapId: MapObjectId('placemark_${_placemarks.length}'),
      point: point,
      text: label != null
          ? PlacemarkText(
              text: label,
              style: const PlacemarkTextStyle(
                size: 12.0,
                color: Color(0xFF000000),
                placement: TextStylePlacement.bottom,
              ),
            )
          : null,
    );
    _placemarks.add(placemark);
    notifyListeners();
  }

  // Удалить все маркеры
  void clearPlacemarks() {
    _placemarks.clear();
    notifyListeners();
  }

  // Переместить камеру к точке
  Future<void> moveToPoint(Point point, {double? zoom}) async {
    if (_mapController == null) return;

    _currentCameraPosition = point;
    if (zoom != null) {
      _zoom = zoom;
    }
    await _mapController!.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: _zoom,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 1.0,
      ),
    );
    notifyListeners();
  }

  // Изменить зум
  Future<void> setZoom(double newZoom) async {
    if (_mapController == null) return;

    _zoom = newZoom.clamp(2.0, 19.0);
    await _mapController!.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentCameraPosition,
          zoom: _zoom,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 0.3,
      ),
    );
    notifyListeners();
  }

  // Переключить тип карты
  void toggleMapType() {
    _mapType = _mapType == MapType.map ? MapType.satellite : MapType.map;
    notifyListeners();
  }

  // Получить текущую позицию камеры
  Future<void> getCurrentCameraPosition() async {
    if (_mapController == null) return;

    final position = await _mapController!.getCameraPosition();
    _currentCameraPosition = position.target;
    _zoom = position.zoom;
    notifyListeners();
  }

  // Результаты поиска
  List<MapSearchResult> _searchResults = [];
  List<MapSearchResult> get searchResults => _searchResults;

  bool get hasSearchResults => _searchResults.isNotEmpty;

  // Поиск адреса (геокодирование)
  Future<Point?> searchAddress(String address) async {
    try {
      setBusy(true);
      // Упрощенная версия поиска - можно расширить позже
      // Для полной реализации нужен API ключ и правильная настройка
      return null;
    } catch (e) {
      return null;
    } finally {
      setBusy(false);
    }
  }

  // Поиск предложений в реальном времени
  Future<void> searchSuggestions(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    try {
      setBusy(true);

      // Временная реализация с моковыми данными
      // TODO: Заменить на реальный API Yandex MapKit Search
      await Future.delayed(const Duration(milliseconds: 300));

      // Моковые результаты для демонстрации
      // TODO: Заменить на реальный API Yandex MapKit Search
      final mockResults = [
        MapSearchResult(
          title: '$query, Санкт-Петербург',
          subtitle: 'Россия, Санкт-Петербург',
          point: _currentCameraPosition,
        ),
        MapSearchResult(
          title: '$query, Москва',
          subtitle: 'Россия, Москва',
          point: const Point(latitude: 55.7558, longitude: 37.6173),
        ),
        MapSearchResult(
          title: '$query, Невский проспект',
          subtitle: 'Санкт-Петербург, Невский проспект',
          point: const Point(latitude: 59.9343, longitude: 30.3351),
        ),
      ];

      _searchResults = mockResults;
      notifyListeners();
    } catch (e) {
      print('❌ Ошибка поиска предложений: $e');
      _searchResults = [];
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  // Очистить результаты поиска
  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }

  // Выбрать результат поиска
  Future<void> selectSearchResult(MapSearchResult result) async {
    try {
      setBusy(true);

      // Используем координаты из результата
      final point = result.point;

      if (point != null) {
        // Перемещаем карту к найденной точке
        await moveToPoint(point);

        // Добавляем маркер
        addPlacemark(point, label: result.title);
      }

      // Очищаем результаты поиска
      clearSearchResults();
    } catch (e) {
      print('❌ Ошибка выбора результата: $e');
    } finally {
      setBusy(false);
    }
  }

  // Обработка нажатия на карту
  void onMapTap(Point point) {
    // Можно добавить логику при нажатии на карту
  }

  // Обработка нажатия на маркер
  void onPlacemarkTap(PlacemarkMapObject placemark) {
    // Можно показать информацию о маркере
  }
}
