import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:adm_panel_v2/features/map/map_viewmodel.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/components/app_app_bar.dart';
import 'package:adm_panel_v2/components/app_floating_panel.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final GlobalKey _viewModelKey = GlobalKey();
  static int _mapInstanceCounter = 0;
  late final int _mapInstanceId;
  // Глобальный ключ для карты - создается один раз и никогда не меняется
  static final GlobalKey _globalMapKey = GlobalKey();
  bool _isDisposed = false;
  bool _isMapCreated = false;
  YandexMapController? _currentMapController;
  MapViewModel? _viewModel;
  final PanelController _panelController = PanelController();

  @override
  void initState() {
    super.initState();
    // Увеличиваем счетчик для каждого нового экземпляра
    _mapInstanceId = _mapInstanceCounter++;
    _isDisposed = false;
    _isMapCreated = false;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _currentMapController = null;
    // PanelController не требует dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.nonReactive(
      key: _viewModelKey,
      viewModelBuilder: () {
        _viewModel ??= MapViewModel();
        return _viewModel!;
      },
      onViewModelReady: (viewModel) async {
        // Инициализация после создания виджета
        // Небольшая задержка для инициализации карты
        await Future.delayed(const Duration(milliseconds: 500));
      },
      builder: (context, model, child) {
        return ViewModelBuilder<MapViewModel>.reactive(
          viewModelBuilder: () => model,
          builder: (context, reactiveModel, child) {
            return Scaffold(
              appBar: AppAppBar.standard(
                title: 'Выбрать адрес',
                actions: [
                  /*
                  IconButton(
                    icon: Icon(
                      reactiveModel.mapType == MapType.map
                          ? Icons.satellite
                          : Icons.map,
                    ),
                    onPressed: () {
                      reactiveModel.toggleMapType();
                    },
                    tooltip: 'Переключить тип карты',
                  ),
                  */
                ],
              ),
              body: AppFloatingPanelStack(
                controller: _panelController,
                // Фоновый контент - карта
                background: Stack(
                  children: [
                    // Yandex карта - используем статический GlobalKey для предотвращения пересоздания
                    // Карта создается один раз и никогда не пересоздается
                    RepaintBoundary(
                      key: const ValueKey('map_boundary'),
                      child: _MapWidget(
                        key: _globalMapKey,
                        mapType: reactiveModel.mapType,
                        placemarks: reactiveModel.placemarks,
                        onMapCreated: (controller) {
                          if (_isDisposed || !mounted) {
                            print(
                                '⚠️ Виджет уже удален, пропускаем инициализацию');
                            return;
                          }
                          if (_isMapCreated &&
                              _currentMapController == controller) {
                            print(
                                '⚠️ Карта уже создана, пропускаем повторную инициализацию');
                            return;
                          }
                          _isMapCreated = true;
                          _currentMapController = controller;
                          print(
                              '🗺️ YandexMap создан (ID: $_mapInstanceId), инициализация контроллера...');
                          model.initMapController(controller);
                        },
                        onMapTap: (point) {
                          if (mounted) {
                            model.onMapTap(point);
                          }
                        },
                      ),
                    ),
                    // Индикатор загрузки, если карта не инициализирована
                    if (!reactiveModel.isMapControllerInitialized)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    // Панель управления
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Column(
                        children: [
                          // Кнопка увеличения зума
                          FloatingActionButton(
                            mini: true,
                            heroTag: 'zoom_in_$_mapInstanceId',
                            onPressed: reactiveModel.isMapControllerInitialized
                                ? () => model.setZoom(model.zoom + 1)
                                : null,
                            backgroundColor: AppColors.surface,
                            child: const Icon(Icons.add,
                                color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 8),
                          // Кнопка уменьшения зума
                          FloatingActionButton(
                            mini: true,
                            heroTag: 'zoom_out_$_mapInstanceId',
                            onPressed: reactiveModel.isMapControllerInitialized
                                ? () => model.setZoom(model.zoom - 1)
                                : null,
                            backgroundColor: AppColors.surface,
                            child: const Icon(Icons.remove,
                                color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 8),
                          // Кнопка текущей позиции
                          FloatingActionButton(
                            mini: true,
                            heroTag: 'my_location_$_mapInstanceId',
                            onPressed: reactiveModel.isMapControllerInitialized
                                ? () => model.moveToPoint(model.initialPoint)
                                : null,
                            backgroundColor: AppColors.primary,
                            child: const Icon(
                              Icons.my_location,
                              color: AppColors.textOnPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Панель со списком
                panel: _MapListPanelContent(
                  controller: _panelController,
                  model: reactiveModel,
                ),
                minHeight: 0.3, // 30% экрана
                maxHeight: 0.8, // 80% экрана
                initialHeight: 0.3, // Начальная высота 30%
                snapPoints: [0.3, 0.5, 0.8], // Snap позиции: 30%, 50%, 80%
                showDragHandle: true,
                allowBackgroundInteraction:
                    true, // Разрешить взаимодействие с картой
              ),
            );
          },
        );
      },
    );
  }
}

// Отдельный виджет для карты, чтобы избежать пересоздания платформенного view
class _MapWidget extends StatefulWidget {
  final MapType mapType;
  final List<PlacemarkMapObject> placemarks;
  final Function(YandexMapController) onMapCreated;
  final Function(Point) onMapTap;

  const _MapWidget({
    super.key,
    required this.mapType,
    required this.placemarks,
    required this.onMapCreated,
    required this.onMapTap,
  });

  @override
  State<_MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<_MapWidget>
    with AutomaticKeepAliveClientMixin {
  // Статический флаг для всего приложения - карта создается только один раз
  static bool _isGloballyInitialized = false;
  bool _isInitialized = false;
  MapType _currentMapType = MapType.map;

  @override
  bool get wantKeepAlive => true; // Сохраняем состояние виджета

  @override
  void initState() {
    super.initState();
    _currentMapType = widget.mapType;
  }

  @override
  void didUpdateWidget(_MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Обновляем тип карты только если он действительно изменился
    if (oldWidget.mapType != widget.mapType && _isInitialized) {
      _currentMapType = widget.mapType;
    }
  }

  @override
  void dispose() {
    // НЕ сбрасываем глобальный флаг при dispose, чтобы карта не пересоздавалась
    _isInitialized = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Требуется для AutomaticKeepAliveClientMixin

    return YandexMap(
      key: const ValueKey(
          'yandex_map_singleton'), // Фиксированный ключ для платформенного view
      mapType: _currentMapType,
      onMapCreated: (controller) {
        // Двойная проверка: локальная и глобальная - карта создается только один раз
        if (_isGloballyInitialized || _isInitialized) {
          print(
              '⚠️ Карта уже инициализирована глобально, пропускаем повторное создание view...');
          return;
        }
        _isGloballyInitialized = true; // Устанавливаем глобальный флаг
        _isInitialized = true;
        _currentMapType = widget.mapType;
        widget.onMapCreated(controller);
      },
      onMapTap: widget.onMapTap,
      mapObjects: widget.placemarks,
    );
  }
}

/// Контент панели со списком для карты
class _MapListPanelContent extends StatelessWidget {
  final PanelController controller;
  final MapViewModel model;

  const _MapListPanelContent({
    required this.controller,
    required this.model,
  });

  // Генерируем 20 элементов для списка
  List<Map<String, dynamic>> get _listData => List.generate(
        20,
        (index) => {
          'id': index + 1,
          'title': 'Точка ${index + 1}',
          'subtitle': 'Адрес точки ${index + 1}',
          'status': index % 3 == 0 ? 'Активна' : 'Неактивна',
          'icon': index % 2 == 0 ? Icons.location_on : Icons.place,
        },
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Заголовок панели
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Список точек (${_listData.length})',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => controller.close(),
                tooltip: 'Закрыть',
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Список элементов
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _listData.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = _listData[index];
              final isActive = item['status'] == 'Активна';

              return Card(
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isActive
                        ? AppColors.success.withOpacity(0.2)
                        : AppColors.error.withOpacity(0.2),
                    child: Icon(
                      item['icon'] as IconData,
                      color: isActive ? AppColors.success : AppColors.error,
                    ),
                  ),
                  title: Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    item['subtitle'],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.success.withOpacity(0.2)
                          : AppColors.error.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item['status'],
                      style: TextStyle(
                        color: isActive ? AppColors.success : AppColors.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Выбрана точка: ${item['title']}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
