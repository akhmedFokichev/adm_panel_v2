import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:adm_panel_v2/components/app_floating_panel.dart';

/// Менеджер для управления несколькими панелями
/// Позволяет открывать разные панели по идентификаторам
class PanelManager {
  PanelManager._();
  static final PanelManager instance = PanelManager._();

  final Map<String, PanelController> _controllers = {};
  final Map<String, Widget> _panels = {};
  BuildContext? _context;

  /// Установить контекст для отображения панелей
  void setContext(BuildContext context) {
    _context = context;
  }

  /// Зарегистрировать панель с идентификатором
  void registerPanel({
    required String id,
    required Widget content,
    double minHeight = 0.3,
    double maxHeight = 0.8,
    double initialHeight = 0.3,
    List<double>? snapPoints,
    bool showDragHandle = true,
    bool allowBackgroundInteraction = false,
  }) {
    _panels[id] = _buildPanelWidget(
      content: content,
      minHeight: minHeight,
      maxHeight: maxHeight,
      initialHeight: initialHeight,
      snapPoints: snapPoints,
      showDragHandle: showDragHandle,
      allowBackgroundInteraction: allowBackgroundInteraction,
    );
  }

  Widget _buildPanelWidget({
    required Widget content,
    required double minHeight,
    required double maxHeight,
    required double initialHeight,
    List<double>? snapPoints,
    required bool showDragHandle,
    required bool allowBackgroundInteraction,
  }) {
    final controller = PanelController();
    return AppFloatingPanel(
      controller: controller,
      minHeight: minHeight,
      maxHeight: maxHeight,
      initialHeight: initialHeight,
      snapPoints: snapPoints,
      showDragHandle: showDragHandle,
      allowBackgroundInteraction: allowBackgroundInteraction,
      onPanelClosed: () {
        _controllers.removeWhere((key, value) => value == controller);
      },
      child: content,
    );
  }

  /// Открыть панель по идентификатору
  void openPanel(String id) {
    if (_context == null) {
      print('⚠️ PanelManager: Context не установлен. Вызовите setContext() сначала.');
      return;
    }

    final panel = _panels[id];
    if (panel == null) {
      print('⚠️ PanelManager: Панель с id "$id" не найдена. Зарегистрируйте её через registerPanel().');
      return;
    }

    // Закрываем все открытые панели
    closeAllPanels();

    // Открываем новую панель
    showModalBottomSheet(
      context: _context!,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => panel,
    );
  }

  /// Закрыть панель по идентификатору
  void closePanel(String id) {
    final controller = _controllers[id];
    controller?.close();
    _controllers.remove(id);
  }

  /// Закрыть все панели
  void closeAllPanels() {
    for (final controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
  }

  /// Проверить, открыта ли панель
  bool isPanelOpen(String id) {
    return _controllers.containsKey(id);
  }

  /// Получить контроллер панели
  PanelController? getController(String id) {
    return _controllers[id];
  }
}

