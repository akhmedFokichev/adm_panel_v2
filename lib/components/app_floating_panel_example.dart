import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:adm_panel_v2/components/app_floating_panel.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Пример использования AppFloatingPanel
///
/// Это аналог FloatingPanel из Swift - универсальный контейнер-шторка,
/// в который можно положить любой экран/виджет
class FloatingPanelExample extends StatelessWidget {
  const FloatingPanelExample({super.key});

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Panel Example'),
      ),
      body: AppFloatingPanelStack(
        controller: panelController,
        // Фоновый контент (например, карта)
        background: Container(
          color: Colors.blue.shade100,
          child: const Center(
            child: Text(
              'Фоновый контент\n(например, карта)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        // Контент панели (любой виджет/экран)
        panel: _buildPanelContent(panelController),
        minHeight: 0.3, // 30% экрана
        maxHeight: 0.8, // 80% экрана
        initialHeight: 0.3, // Начальная высота 30%
        snapPoints: [0.3, 0.5, 0.8], // Snap позиции: 30%, 50%, 80%
        showDragHandle: true,
      ),
    );
  }

  Widget _buildPanelContent(PanelController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Контент панели',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Это может быть любой виджет или даже целый экран!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Программное управление панелью
                controller.open();
              },
              child: const Text('Открыть панель'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                controller.close();
              },
              child: const Text('Закрыть панель'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Переместить к snap-позиции
                controller.animatePanelToPosition(
                  0.5, // 50% экрана
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: const Text('Переместить к 50%'),
            ),
            const SizedBox(height: 24),
            // Пример: можно вставить любой виджет
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Text('Пример карточки'),
                  SizedBox(height: 8),
                  Text('Здесь может быть любой контент'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Можно даже встроить другой экран через виджет
            Container(
              height: 200,
              color: Colors.green.shade100,
              child: const Center(
                child: Text('Здесь может быть\nлюбой другой экран'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Пример использования как модального окна
class FloatingPanelModalExample extends StatelessWidget {
  const FloatingPanelModalExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Panel Modal'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Показать панель как модальное окно
            AppFloatingPanel.showModal(
              context: context,
              child: _buildModalContent(context),
              minHeight: 0.3,
              maxHeight: 0.8,
              initialHeight: 0.3,
              snapPoints: [0.3, 0.5, 0.8],
            );
          },
          child: const Text('Показать модальную панель'),
        ),
      ),
    );
  }

  Widget _buildModalContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Модальная панель',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
                'Это модальная панель, которая может содержать любой контент.'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Закрыть'),
            ),
          ],
        ),
      ),
    );
  }
}
