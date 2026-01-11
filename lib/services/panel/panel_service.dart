import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:adm_panel_v2/components/app_floating_panel.dart';
import 'package:adm_panel_v2/router/app_router.dart';

/// Сервис для управления шторками (Floating Panels)
/// Позволяет открывать разные экраны в шторке динамически
class PanelService {
  PanelService._();
  static final PanelService instance = PanelService._();

  PanelController? _currentPanelController;

  /// Получить контекст из глобального навигатора
  BuildContext? get _context {
    return AppRouter.navigatorKey.currentContext;
  }

  /// Открыть панель с указанным контентом
  void openPanel({
    required Widget content,
    double minHeight = 0.3,
    double maxHeight = 0.8,
    double initialHeight = 0.3,
    List<double>? snapPoints,
    bool showDragHandle = true,
    bool allowBackgroundInteraction = false,
    VoidCallback? onClosed,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ PanelService: Navigator context недоступен. Убедитесь, что приложение инициализировано.');
      return;
    }

    // Закрываем предыдущую панель, если она открыта
    closePanel();

    _currentPanelController = PanelController();

    // Показываем панель как overlay
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AppFloatingPanel(
        controller: _currentPanelController,
        minHeight: minHeight,
        maxHeight: maxHeight,
        initialHeight: initialHeight,
        snapPoints: snapPoints,
        showDragHandle: showDragHandle,
        allowBackgroundInteraction: allowBackgroundInteraction,
        onPanelClosed: () {
          _currentPanelController = null;
          onClosed?.call();
        },
        child: content,
      ),
    );
  }

  /// Закрыть текущую панель
  void closePanel() {
    _currentPanelController?.close();
    _currentPanelController = null;
  }

  /// Проверить, открыта ли панель
  bool get isPanelOpen => _currentPanelController != null;

  /// Получить текущий контроллер панели
  PanelController? get currentController => _currentPanelController;
}

