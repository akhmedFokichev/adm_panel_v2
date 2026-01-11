import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:adm_panel_v2/features/home/home_viewmodel.dart';
import 'package:adm_panel_v2/components/app_bottom_sheet.dart';
import 'package:adm_panel_v2/components/app_button.dart';
import 'package:adm_panel_v2/components/app_card.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(model.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton.primary(
                label: 'Открыть шторку (50%)',
                onPressed: () {
                  AppBottomSheet.show(
                    context: context,
                    title: 'Заголовок шторки',
                    initialHeight: AppBottomSheetHeight.medium,
                    child: _buildBottomSheetContent(),
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton.secondary(
                label: 'Открыть шторку (80%)',
                onPressed: () {
                  AppBottomSheet.show(
                    context: context,
                    title: 'Большая шторка',
                    initialHeight: AppBottomSheetHeight.large,
                    child: _buildBottomSheetContent(),
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton.secondary(
                label: 'Простая шторка',
                onPressed: () {
                  AppSimpleBottomSheet.show(
                    context: context,
                    title: 'Простая шторка',
                    height: 300,
                    child: _buildSimpleContent(),
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton.primary(
                label: 'Шторка с snap (40% → 90%)',
                onPressed: () {
                  AppSnapBottomSheet.showWithSnaps(
                    context: context,
                    title: 'Шторка с snap-позициями',
                    snapSizes: const [0.4, 0.9], // 40% и 90%
                    initialSnapIndex: 0, // Начинаем с 40%
                    isDismissible: false, // Нельзя закрыть свайпом вниз
                    barrierDismissible:
                        false, // Не закрывается при клике на барьер
                    barrierColor: Colors
                        .transparent, // Прозрачный барьер - не блокирует экран
                    child: _buildSnapContent(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Это пример контента в bottom sheet',
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Вы можете смахивать шторку вверх и вниз для изменения размера.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate(
          10,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppCard.outlined(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: AppColors.textOnPrimary),
                  ),
                ),
                title: Text('Элемент ${index + 1}'),
                subtitle: Text('Описание элемента ${index + 1}'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSimpleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Простая шторка с фиксированной высотой',
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Эта шторка имеет фиксированную высоту и не может быть растянута.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        AppButton.primary(
          label: 'Кнопка в шторке',
          onPressed: () {},
          isFullWidth: true,
        ),
        const SizedBox(height: 16),
        AppButton.secondary(
          label: 'Вторая кнопка',
          onPressed: () {},
          isFullWidth: true,
        ),
      ],
    );
  }

  Widget _buildSnapContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Смахивайте вверх до 90% или вниз до 40%',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Контент шторки',
          style: AppTextStyles.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Эта шторка имеет две фиксированные позиции:\n• 40% экрана (начальная)\n• 90% экрана (растянутая)',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate(
          20,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: AppColors.textOnPrimary,
                    fontSize: 12,
                  ),
                ),
              ),
              title: Text('Элемент списка ${index + 1}'),
              subtitle: Text('Подзаголовок элемента ${index + 1}'),
              trailing: const Icon(Icons.chevron_right, size: 20),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
