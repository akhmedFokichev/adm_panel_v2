import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:adm_panel_v2/components/app_floating_panel.dart';

/// Обертка для экрана, которая позволяет открывать панели динамически
/// Используйте этот виджет как корневой для экранов, где нужны панели
class PanelWrapper extends StatefulWidget {
  final Widget child;
  final Widget? background;

  const PanelWrapper({
    super.key,
    required this.child,
    this.background,
  });

  @override
  State<PanelWrapper> createState() => _PanelWrapperState();
}

class _PanelWrapperState extends State<PanelWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Виджет для отображения панели поверх контента
class PanelOverlay extends StatefulWidget {
  final Widget child;
  final Widget? panelContent;
  final PanelController? panelController;
  final double minHeight;
  final double maxHeight;
  final double initialHeight;
  final List<double>? snapPoints;
  final bool showDragHandle;
  final bool allowBackgroundInteraction;

  const PanelOverlay({
    super.key,
    required this.child,
    this.panelContent,
    this.panelController,
    this.minHeight = 0.3,
    this.maxHeight = 0.8,
    this.initialHeight = 0.3,
    this.snapPoints,
    this.showDragHandle = true,
    this.allowBackgroundInteraction = false,
  });

  @override
  State<PanelOverlay> createState() => _PanelOverlayState();
}

class _PanelOverlayState extends State<PanelOverlay> {
  PanelController? _panelController;
  Widget? _currentPanelContent;

  @override
  void initState() {
    super.initState();
    _panelController = widget.panelController ?? PanelController();
  }

  void showPanel(Widget content) {
    setState(() {
      _currentPanelContent = content;
    });
    _panelController?.open();
  }

  void hidePanel() {
    _panelController?.close();
    setState(() {
      _currentPanelContent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPanelContent == null) {
      return widget.child;
    }

    return AppFloatingPanelStack(
      controller: _panelController,
      background: widget.child,
      panel: _currentPanelContent!,
      minHeight: widget.minHeight,
      maxHeight: widget.maxHeight,
      initialHeight: widget.initialHeight,
      snapPoints: widget.snapPoints,
      showDragHandle: widget.showDragHandle,
      allowBackgroundInteraction: widget.allowBackgroundInteraction,
      onPanelSlide: (position) {
        // Можно добавить логику при изменении позиции
      },
    );
  }
}

