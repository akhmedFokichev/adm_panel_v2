import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:adm_panel_v2/components/app_floating_panel.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

/// Пример экрана с таблицей из 20 элементов в FloatingPanel
class FloatingPanelTableExample extends StatelessWidget {
  const FloatingPanelTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Таблица в Floating Panel'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: AppFloatingPanelStack(
        controller: panelController,
        // Фоновый контент
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.surface,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 64,
                  color: AppColors.primary.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'Фоновый контент',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Потяните панель вверх, чтобы увидеть таблицу',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        // Панель с таблицей
        panel: _TablePanelContent(controller: panelController),
        minHeight: 0.3, // 30% экрана
        maxHeight: 0.9, // 90% экрана
        initialHeight: 0.3, // Начальная высота 30%
        snapPoints: [0.3, 0.6, 0.9], // Snap позиции: 30%, 60%, 90%
        showDragHandle: true,
        allowBackgroundInteraction: true, // Разрешить взаимодействие с фоном
      ),
    );
  }
}

/// Контент панели с таблицей
class _TablePanelContent extends StatelessWidget {
  final PanelController controller;

  const _TablePanelContent({required this.controller});

  // Генерируем 20 элементов для таблицы
  List<Map<String, dynamic>> get _tableData => List.generate(
        20,
        (index) => {
          'id': index + 1,
          'name': 'Элемент ${index + 1}',
          'description': 'Описание элемента ${index + 1}',
          'status': index % 3 == 0 ? 'Активен' : 'Неактивен',
          'date': '2024-01-${(index % 28) + 1}',
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
                'Таблица элементов',
                style: AppTextStyles.titleLarge.copyWith(
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
        // Таблица
        Expanded(
          child: _buildTable(),
        ),
      ],
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 24,
          headingRowColor: WidgetStateProperty.all(
            AppColors.surfaceVariant,
          ),
          columns: const [
            DataColumn(
              label: Text(
                'ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Название',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Описание',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Статус',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Дата',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _tableData.map((item) => _buildTableRow(item)).toList(),
        ),
      ),
    );
  }

  /// Создает строку таблицы для элемента
  DataRow _buildTableRow(Map<String, dynamic> item) {
    final isActive = item['status'] == 'Активен';

    return DataRow(
      cells: [
        DataCell(Text('${item['id']}')),
        DataCell(
          Text(
            item['name'],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        DataCell(
          SizedBox(
            width: 150,
            child: Text(
              item['description'],
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(_buildStatusCell(item, isActive)),
        DataCell(Text(item['date'])),
      ],
    );
  }

  /// Создает ячейку со статусом
  Widget _buildStatusCell(Map<String, dynamic> item, bool isActive) {
    return Container(
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
    );
  }
}

/// Альтернативный вариант с ListView (более производительный для больших списков)
class FloatingPanelListExample extends StatelessWidget {
  const FloatingPanelListExample({super.key});

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список в Floating Panel'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: AppFloatingPanelStack(
        controller: panelController,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.surface,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.list,
                  size: 64,
                  color: AppColors.primary.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'Фоновый контент',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    print("tap");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Нажми меня'),
                ),
              ],
            ),
          ),
        ),
        panel: _ListPanelContent(controller: panelController),
        minHeight: 0.3,
        maxHeight: 0.9,
        initialHeight: 0.3,
        snapPoints: [0.3, 0.6, 0.9],
        showDragHandle: true,
      ),
    );
  }
}

/// Контент панели со списком
class _ListPanelContent extends StatelessWidget {
  final PanelController controller;

  const _ListPanelContent({required this.controller});

  // Генерируем 20 элементов для списка
  List<Map<String, dynamic>> get _listData => List.generate(
        20,
        (index) => {
          'id': index + 1,
          'title': 'Элемент ${index + 1}',
          'subtitle': 'Подзаголовок элемента ${index + 1}',
          'status': index % 3 == 0 ? 'Активен' : 'Неактивен',
          'icon': index % 2 == 0 ? Icons.check_circle : Icons.cancel,
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
                'Список элементов (${_listData.length})',
                style: AppTextStyles.titleLarge.copyWith(
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
              final isActive = item['status'] == 'Активен';

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
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    item['subtitle'],
                    style: AppTextStyles.bodyMedium.copyWith(
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
                        content: Text('Выбран элемент: ${item['title']}'),
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
