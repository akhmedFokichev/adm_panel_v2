import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Аналог FloatingPanel из Swift для Flutter
/// Универсальный контейнер-шторка, в который можно положить любой экран/виджет
class AppFloatingPanel extends StatelessWidget {
  /// Контент панели (любой виджет/экран)
  final Widget child;

  /// Минимальная высота панели (в долях от высоты экрана, 0.0 - 1.0)
  final double minHeight;

  /// Максимальная высота панели (в долях от высоты экрана, 0.0 - 1.0)
  final double maxHeight;

  /// Начальная высота панели (в долях от высоты экрана, 0.0 - 1.0)
  final double initialHeight;

  /// Snap-позиции (фиксированные точки остановки)
  final List<double>? snapPoints;

  /// Показывать ли драггер (ручку для перетаскивания)
  final bool showDragHandle;

  /// Цвет фона панели
  final Color? backgroundColor;

  /// Скругление углов
  final BorderRadius? borderRadius;

  /// Тень панели
  final List<BoxShadow>? boxShadow;

  /// Callback при изменении позиции панели
  final ValueChanged<double>? onPanelSlide;

  /// Callback при открытии панели
  final VoidCallback? onPanelOpened;

  /// Callback при закрытии панели
  final VoidCallback? onPanelClosed;

  /// Контроллер панели (для программного управления)
  final PanelController? controller;

  /// Разрешить взаимодействие с фоновым контентом (не блокировать экран под шторкой)
  final bool allowBackgroundInteraction;

  const AppFloatingPanel({
    super.key,
    required this.child,
    this.minHeight = 0.3,
    this.maxHeight = 0.8,
    this.initialHeight = 0.3,
    this.snapPoints,
    this.showDragHandle = true,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.onPanelSlide,
    this.onPanelOpened,
    this.onPanelClosed,
    this.controller,
    this.allowBackgroundInteraction = false,
  })  : assert(
          minHeight >= 0.0 && minHeight <= 1.0,
          'minHeight must be between 0.0 and 1.0',
        ),
        assert(
          maxHeight >= 0.0 && maxHeight <= 1.0,
          'maxHeight must be between 0.0 and 1.0',
        ),
        assert(
          initialHeight >= minHeight && initialHeight <= maxHeight,
          'initialHeight must be between minHeight and maxHeight',
        );

  /// Показать панель как модальное окно
  static Future<T?> showModal<T>({
    required BuildContext context,
    required Widget child,
    double minHeight = 0.3,
    double maxHeight = 0.8,
    double initialHeight = 0.3,
    List<double>? snapPoints,
    bool showDragHandle = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AppFloatingPanel(
        minHeight: minHeight,
        maxHeight: maxHeight,
        initialHeight: initialHeight,
        snapPoints: snapPoints,
        showDragHandle: showDragHandle,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SlidingUpPanel(
      controller: controller,
      minHeight: screenHeight * minHeight,
      maxHeight: screenHeight * maxHeight,
      defaultPanelState: PanelState.OPEN,
      // snapPoint должен быть в долях от 0.0 до 1.0, а не в пикселях
      snapPoint: snapPoints != null && snapPoints!.isNotEmpty
          ? snapPoints!.first.clamp(0.01, 0.99)
          : null,
      panelSnapping: snapPoints != null && snapPoints!.isNotEmpty,
      borderRadius: borderRadius ??
          const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: AppColors.shadowDark,
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
      color: backgroundColor ?? AppColors.surface,
      onPanelSlide: onPanelSlide,
      onPanelOpened: onPanelOpened,
      onPanelClosed: onPanelClosed,
      panel: Column(
        children: [
          // Драггер (ручка для перетаскивания)
          if (showDragHandle) _buildDragHandle(),
          // Контент панели
          Expanded(child: child),
        ],
      ),
      body: const SizedBox.shrink(), // Пустое тело, так как это контейнер
    );
  }

  Widget _buildDragHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// Расширенная версия с возможностью встраивания в Stack
class AppFloatingPanelStack extends StatelessWidget {
  /// Фоновый контент (например, карта)
  final Widget background;

  /// Контент панели
  final Widget panel;

  /// Минимальная высота панели
  final double minHeight;

  /// Максимальная высота панели
  final double maxHeight;

  /// Начальная высота панели
  final double initialHeight;

  /// Snap-позиции
  final List<double>? snapPoints;

  /// Показывать ли драггер
  final bool showDragHandle;

  /// Контроллер панели
  final PanelController? controller;

  /// Callback при изменении позиции
  final ValueChanged<double>? onPanelSlide;

  /// Разрешить взаимодействие с фоновым контентом (не блокировать экран под шторкой)
  /// Когда true, можно взаимодействовать с фоном даже когда панель открыта
  final bool allowBackgroundInteraction;

  const AppFloatingPanelStack({
    super.key,
    required this.background,
    required this.panel,
    this.minHeight = 0.3,
    this.maxHeight = 0.8,
    this.initialHeight = 0.3,
    this.snapPoints,
    this.showDragHandle = true,
    this.controller,
    this.onPanelSlide,
    this.allowBackgroundInteraction = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SlidingUpPanel(
      controller: controller,
      minHeight: screenHeight * minHeight,
      maxHeight: screenHeight * maxHeight,
      defaultPanelState: PanelState.OPEN,
      // snapPoint должен быть в долях от 0.0 до 1.0, а не в пикселях
      snapPoint: snapPoints != null && snapPoints!.isNotEmpty
          ? snapPoints!.first.clamp(0.01, 0.99)
          : null,
      panelSnapping: snapPoints != null && snapPoints!.isNotEmpty,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowDark,
          blurRadius: 20,
          offset: const Offset(0, -5),
        ),
      ],
      color: AppColors.surface,
      onPanelSlide: onPanelSlide,
      panel: Column(
        children: [
          // Драггер
          if (showDragHandle)
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          // Контент панели
          Expanded(child: panel),
        ],
      ),
      body: background,
      // В sliding_up_panel фоновый контент уже интерактивен по умолчанию
      // Параметр allowBackgroundInteraction используется для документации и будущих расширений
      isDraggable: true,
    );
  }
}
