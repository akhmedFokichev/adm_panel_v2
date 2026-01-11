import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// ViewModel для экрана выбора адреса
class SelectAddressViewModel extends BaseViewModel {
  // Контроллер карты
  YandexMapController? _mapController;

  YandexMapController? get mapController => _mapController;

  bool get isMapControllerInitialized => _mapController != null;

  // Начальная позиция (Санкт-Петербург)
  final Point _initialPoint = const Point(
    latitude: 59.9343,
    longitude: 30.3351,
  );

  Point get initialPoint => _initialPoint;

  // Текущая позиция камеры
  Point _currentCameraPosition = const Point(
    latitude: 59.9343,
    longitude: 30.3351,
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

  // Выбранная точка на карте
  Point? _selectedPoint;
  Point? get selectedPoint => _selectedPoint;

  void initialize() {
    // Инициализация экрана
  }

  Future<void> initMapController(YandexMapController controller) async {
    if (_mapController != null && _mapController == controller) {
      return;
    }

    _mapController = controller;

    // Даем карте время на инициализацию
    await Future.delayed(const Duration(milliseconds: 500));

    // Устанавливаем начальную позицию камеры
    try {
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
    } catch (e) {
      print('❌ Ошибка инициализации карты: $e');
    }
  }

  // Обработка нажатия на карту
  void onMapTap(Point point) {
    _selectedPoint = point;

    // Удаляем старые маркеры
    _placemarks.clear();

    // Добавляем новый маркер в выбранную точку
    final placemark = PlacemarkMapObject(
      mapId: const MapObjectId('selected_point'),
      point: point,
      text: const PlacemarkText(
        text: 'Выбранный адрес',
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
}
