import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:adm_panel_v2/features/design_system/design_system_viewmodel.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/components/components.dart';
import 'package:adm_panel_v2/components/app_scrollable_labels.dart';
import 'package:adm_panel_v2/components/app_transport_item.dart';
import 'package:adm_panel_v2/components/app_social_button.dart';

/// Обертка для DesignSystemView для использования в MainView
class DesignSystemTab extends StatelessWidget {
  const DesignSystemTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DesignSystemViewModel>.reactive(
      viewModelBuilder: () => DesignSystemViewModel(),
      builder: (context, model, child) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Карточки и рамки'),
            _buildCardsSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Кнопки'),
            _buildButtonsSection(model),
            const SizedBox(height: 32),
            _buildSectionTitle('Радио-кнопки'),
            _buildRadioButtonsSection(model),
            const SizedBox(height: 32),
            _buildSectionTitle('Теги и лейблы'),
            _buildTagsSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Прокручиваемые лейблы'),
            _buildScrollableLabelsSection(model),
            const SizedBox(height: 32),
            _buildSectionTitle('Чекбоксы'),
            _buildCheckboxesSection(model),
            const SizedBox(height: 32),
            _buildSectionTitle('Счетчики'),
            _buildCountersSection(model),
            const SizedBox(height: 32),
            _buildSectionTitle('Прогресс бары'),
            _buildProgressBarsSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Инпуты'),
            _buildInputsSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Способы регистрации'),
            _buildSocialButtonsSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Виды транспорта'),
            _buildTransportSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Навигационные панели'),
            _buildNavigationBarsSection(model),
            const SizedBox(height: 32),
            _buildSectionTitle('AppBar варианты'),
            _buildAppBarsSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Bottom Sheet (Шторки)'),
            _buildBottomSheetsSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Алерты и уведомления'),
            _buildAlertsSection(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: AppTextStyles.headlineSmall.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildButtonsSection(DesignSystemViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentCard(
          'Elevated Button',
          ElevatedButton(
            onPressed: () {},
            child: const Text('Elevated Button'),
          ),
        ),
        _buildComponentCard(
          'Outlined Button',
          OutlinedButton(
            onPressed: () {},
            child: const Text('Outlined Button'),
          ),
        ),
        _buildComponentCard(
          'Text Button',
          TextButton(
            onPressed: () {},
            child: const Text('Text Button'),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButtonsSection(DesignSystemViewModel model) {
    return Column(
      children: [
        _buildComponentCard(
          'Radio Buttons',
          Column(
            children: [
              AppRadioButton(
                value: 'option1',
                groupValue: model.selectedRadioValue,
                label: 'Опция 1',
                onChanged: model.setRadioValue,
              ),
              AppRadioButton(
                value: 'option2',
                groupValue: model.selectedRadioValue,
                label: 'Опция 2',
                onChanged: model.setRadioValue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        AppTag(label: 'Тег 1'),
        AppTag(label: 'Тег 2'),
        AppTag(label: 'Тег 3'),
      ],
    );
  }

  Widget _buildScrollableLabelsSection(DesignSystemViewModel model) {
    final labels = const [
      ScrollableLabel(id: '1', label: 'Все', icon: Icons.apps),
      ScrollableLabel(id: '2', label: 'Активные', icon: Icons.check_circle),
      ScrollableLabel(id: '3', label: 'Неактивные', icon: Icons.cancel),
      ScrollableLabel(id: '4', label: 'VIP', icon: Icons.star),
      ScrollableLabel(id: '5', label: 'Новые', icon: Icons.new_releases),
    ];

    return AppScrollableLabels(
      labels: labels,
      selectedIds: model.selectedLabelIds,
      onLabelTap: model.toggleLabel,
    );
  }

  Widget _buildCheckboxesSection(DesignSystemViewModel model) {
    return Column(
      children: [
        _buildComponentCard(
          'Checkboxes',
          Column(
            children: [
              AppCheckbox(
                value: model.checkboxDefault,
                onChanged: (value) => model.setCheckboxDefault(value ?? false),
                label: 'Чекбокс по умолчанию',
              ),
              AppCheckbox(
                value: model.checkboxSelected,
                onChanged: (value) => model.setCheckboxSelected(value ?? false),
                label: 'Выбранный чекбокс',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCountersSection(DesignSystemViewModel model) {
    return Row(
      children: [
        _buildComponentCard(
          'Счетчик взрослых',
          AppCounter(
            label: 'Взрослые',
            value: model.adultsCount,
            onChanged: model.setAdultsCount,
          ),
        ),
        const SizedBox(width: 16),
        _buildComponentCard(
          'Счетчик детей',
          AppCounter(
            label: 'Дети',
            value: model.childrenCount,
            onChanged: model.setChildrenCount,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBarsSection() {
    return Column(
      children: [
        _buildComponentCard(
          'Progress Bar',
          AppProgressBar(value: 0.6),
        ),
      ],
    );
  }

  Widget _buildInputsSection() {
    return Column(
      children: [
        _buildComponentCard(
          'Text Field',
          TextField(
            decoration: const InputDecoration(
              labelText: 'Введите текст',
              hintText: 'Подсказка',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtonsSection() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        AppSocialButton(
          provider: SocialProvider.google,
          onPressed: () {},
        ),
        AppSocialButton(
          provider: SocialProvider.apple,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTransportSection() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        AppTransportItem(
          label: 'Электросамокат',
          icon: Icons.electric_scooter,
        ),
        AppTransportItem(
          label: 'Автобус',
          icon: Icons.directions_bus,
        ),
      ],
    );
  }

  Widget _buildNavigationBarsSection(DesignSystemViewModel model) {
    return Column(
      children: [
        _buildComponentCard(
          'Bottom Navigation Bar',
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
            ),
            child: AppNavigationBar(
              currentIndex: model.bottomNavIndex,
              onTap: model.setBottomNavIndex,
              items: const [
                AppNavBarItem(icon: Icons.home, label: 'Главная'),
                AppNavBarItem(icon: Icons.search, label: 'Поиск'),
                AppNavBarItem(icon: Icons.favorite, label: 'Избранное'),
                AppNavBarItem(icon: Icons.person, label: 'Профиль'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarsSection() {
    return Column(
      children: [
        _buildComponentCard(
          'App Bar',
          AppAppBar(
            title: 'Заголовок',
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheetsSection() {
    return ElevatedButton(
      onPressed: () {
        // TODO: Показать bottom sheet
      },
      child: const Text('Показать Bottom Sheet'),
    );
  }

  Widget _buildAlertsSection(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // TODO: Показать alert
          },
          child: const Text('Показать Alert'),
        ),
      ],
    );
  }

  Widget _buildCardsSection() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        AppCard(
          child: const Text('Обычная карточка'),
        ),
        AppCard.outlined(
          child: const Text('Карточка с рамкой'),
        ),
        AppCard.elevated(
          child: const Text('Карточка с тенью'),
        ),
        AppCard.filled(
          child: const Text('Заполненная карточка'),
        ),
      ],
    );
  }

  Widget _buildComponentCard(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
