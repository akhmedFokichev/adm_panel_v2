import 'package:flutter/material.dart';
import 'package:adm_panel_v2/services/panel/panel_service.dart';
import 'package:adm_panel_v2/services/panel/panel_wrapper.dart';
import 'package:adm_panel_v2/design/app_colors.dart';

/// Пример использования PanelService для динамического открытия панелей
class PanelServiceExample extends StatelessWidget {
  const PanelServiceExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Обертываем экран в PanelWrapper для работы с панелями
    return PanelWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Пример панелей'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Открываем первую панель
                  PanelService.instance.openPanel(
                    content: _buildFirstPanel(),
                    minHeight: 0.3,
                    maxHeight: 0.8,
                    snapPoints: [0.3, 0.5, 0.8],
                  );
                },
                child: const Text('Открыть панель 1'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Открываем вторую панель
                  PanelService.instance.openPanel(
                    content: _buildSecondPanel(),
                    minHeight: 0.4,
                    maxHeight: 0.9,
                    snapPoints: [0.4, 0.7, 0.9],
                  );
                },
                child: const Text('Открыть панель 2'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Открываем третью панель (список)
                  PanelService.instance.openPanel(
                    content: _buildListPanel(),
                    minHeight: 0.3,
                    maxHeight: 0.9,
                    snapPoints: [0.3, 0.6, 0.9],
                  );
                },
                child: const Text('Открыть панель со списком'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Закрываем текущую панель
                  PanelService.instance.closePanel();
                },
                child: const Text('Закрыть панель'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPanel() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Панель 1',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Это первая панель с кастомным контентом'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              PanelService.instance.closePanel();
            },
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondPanel() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Панель 2',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Это вторая панель с другим контентом'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              PanelService.instance.closePanel();
            },
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildListPanel() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Список элементов',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  PanelService.instance.closePanel();
                },
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Элемент ${index + 1}'),
                  subtitle: Text('Описание элемента ${index + 1}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Выбран элемент ${index + 1}'),
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

