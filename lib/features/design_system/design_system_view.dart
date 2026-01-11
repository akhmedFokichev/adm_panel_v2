import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:adm_panel_v2/features/design_system/design_system_viewmodel.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/components/components.dart';

class DesignSystemView extends StatelessWidget {
  const DesignSystemView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DesignSystemViewModel>.reactive(
      viewModelBuilder: () => DesignSystemViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Дизайн-система'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildComponentLabel('S Primary with icon'),
              const SizedBox(height: 8),
              AppButton.primary(
                label: 'Кнопка',
                icon: Icons.star,
                size: AppButtonSize.small,
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildComponentLabel('S Secondary with icon'),
              const SizedBox(height: 8),
              AppButton.secondary(
                label: 'Кнопка',
                icon: Icons.star,
                size: AppButtonSize.small,
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildComponentLabel('S Inactive with icon'),
              const SizedBox(height: 8),
              const AppButton.inactive(
                label: 'Кнопка',
                icon: Icons.star,
                size: AppButtonSize.small,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildComponentLabel('Secondary with price'),
              const SizedBox(height: 8),
              AppButton.secondary(
                label: 'Кнопка',
                price: '1 000 ₽',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButtonsSection(DesignSystemViewModel model) {
    return _buildComponentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRadioButton<String>(
            value: 'default',
            groupValue: model.selectedRadioValue,
            onChanged: model.setRadioValue,
            label: 'Дефолтное',
          ),
          const SizedBox(height: 16),
          AppRadioButton<String>(
            value: 'selected',
            groupValue: model.selectedRadioValue,
            onChanged: model.setRadioValue,
            label: 'Выбранное',
          ),
          const SizedBox(height: 16),
          const AppRadioButton<String>(
            value: 'inactive_empty',
            groupValue: 'inactive_empty',
            label: 'Неактивное пустое',
            isEnabled: false,
          ),
          const SizedBox(height: 16),
          const AppRadioButton<String>(
            value: 'inactive_selected',
            groupValue: 'inactive_selected',
            label: 'Неактивное выбранное',
            isEnabled: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        const AppTag(label: 'Пешком'),
        const AppTag.secondary(label: 'На автобусе'),
        AppTag(
          label: 'Пешком',
          icon: Icons.directions_walk,
        ),
        const AppTag.primary(label: 'Развлечения'),
        const AppTag(label: 'Фестивали'),
      ],
    );
  }

  Widget _buildScrollableLabelsSection(DesignSystemViewModel model) {
    final labels = [
      const ScrollableLabel(
        id: '1',
        label: 'Все',
        icon: Icons.apps,
      ),
      const ScrollableLabel(
        id: '2',
        label: 'Пицца',
        icon: Icons.local_pizza,
      ),
      const ScrollableLabel(
        id: '3',
        label: 'Суши',
        icon: Icons.set_meal,
      ),
      const ScrollableLabel(
        id: '4',
        label: 'Бургеры',
        icon: Icons.lunch_dining,
      ),
      const ScrollableLabel(
        id: '5',
        label: 'Десерты',
        icon: Icons.cake,
      ),
      const ScrollableLabel(
        id: '6',
        label: 'Напитки',
        icon: Icons.local_drink,
      ),
      const ScrollableLabel(
        id: '7',
        label: 'Салаты',
        icon: Icons.restaurant,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentLabel('Множественный выбор (по умолчанию)'),
        const SizedBox(height: 8),
        _buildComponentCard(
          child: AppScrollableLabels(
            labels: labels,
            selectedIds: model.selectedLabelIds,
            onLabelTap: model.toggleLabel,
            spacing: 12,
            allowMultipleSelection: true,
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Режим радиокнопки (одиночный выбор)'),
        const SizedBox(height: 8),
        _buildComponentCard(
          child: AppScrollableLabels(
            labels: labels,
            selectedIds: model.singleSelectedLabelIds,
            onLabelTap: model.selectSingleLabel,
            spacing: 12,
            allowMultipleSelection: false,
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Режим радиокнопки с иконками'),
        const SizedBox(height: 8),
        _buildComponentCard(
          child: AppScrollableLabels(
            labels: labels,
            selectedIds: model.singleSelectedLabelIds,
            onLabelTap: model.selectSingleLabel,
            spacing: 12,
            allowMultipleSelection: false,
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Кастомные стили (множественный выбор)'),
        const SizedBox(height: 8),
        _buildComponentCard(
          child: AppScrollableLabels.custom(
            labels: labels,
            selectedIds: model.selectedLabelIds,
            onLabelTap: model.toggleLabel,
            spacing: 12,
            allowMultipleSelection: true,
            selectedStyle: const LabelStyle(
              backgroundColor: AppColors.success,
              textColor: AppColors.textOnPrimary,
            ),
            unselectedStyle: const LabelStyle(
              backgroundColor: AppColors.surfaceVariant,
              textColor: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxesSection(DesignSystemViewModel model) {
    return _buildComponentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCheckbox(
            value: model.checkboxDefault,
            onChanged: (value) => model.setCheckboxDefault(value ?? false),
            label: 'Дефолтное',
          ),
          const SizedBox(height: 16),
          AppCheckbox(
            value: model.checkboxSelected,
            onChanged: (value) => model.setCheckboxSelected(value ?? false),
            label: 'Выбранное',
          ),
          const SizedBox(height: 16),
          const AppCheckbox(
            value: false,
            label: 'Неактивное пустое',
            isEnabled: false,
          ),
          const SizedBox(height: 16),
          const AppCheckbox(
            value: true,
            label: 'Неактивное выбранное',
            isEnabled: false,
          ),
        ],
      ),
    );
  }

  Widget _buildCountersSection(DesignSystemViewModel model) {
    return _buildComponentCard(
      child: Column(
        children: [
          AppCounter(
            label: 'Взрослые',
            subtitle: '16 лет и старше',
            value: model.adultsCount,
            onChanged: model.setAdultsCount,
          ),
          const SizedBox(height: 24),
          AppCounter(
            label: 'Дети',
            value: model.childrenCount,
            onChanged: model.setChildrenCount,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBarsSection() {
    return _buildComponentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppProgressBar(value: 0.0),
          const SizedBox(height: 16),
          AppProgressBar(value: 0.25),
          const SizedBox(height: 16),
          AppProgressBar(value: 0.5),
          const SizedBox(height: 16),
          AppProgressBar(value: 0.75),
          const SizedBox(height: 16),
          AppProgressBar(value: 1.0),
        ],
      ),
    );
  }

  Widget _buildInputsSection() {
    return Column(
      children: [
        _buildComponentCard(
          child: const TextField(
            decoration: InputDecoration(
              labelText: 'Текстовое поле',
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentCard(
          child: const TextField(
            decoration: InputDecoration(
              labelText: 'Развернутые пожелания (необязательно)',
              suffixIcon: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentCard(
          child: const TextField(
            decoration: InputDecoration(
              labelText: 'Телефон или e-mail',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtonsSection() {
    return _buildComponentCard(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          AppSocialButton(
            provider: SocialProvider.vk,
            onPressed: () {},
          ),
          AppSocialButton(
            provider: SocialProvider.yandex,
            onPressed: () {},
          ),
          AppSocialButton(
            provider: SocialProvider.google,
            onPressed: () {},
          ),
          AppSocialButton(
            provider: SocialProvider.apple,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTransportSection() {
    return _buildComponentCard(
      child: Column(
        children: [
          AppTransportItem(
            label: 'Электросамокаты',
            icon: Icons.electric_scooter,
            showAddButton: true,
            onAdd: () {},
          ),
          const SizedBox(height: 12),
          AppTransportItem(
            label: 'Общественный транспорт',
            icon: Icons.directions_bus,
          ),
          const SizedBox(height: 12),
          AppTransportItem(
            label: 'Прокат спорт. инвентаря',
            icon: Icons.sports,
            showAddButton: true,
            onAdd: () {},
          ),
          const SizedBox(height: 12),
          AppTransportItem(
            label: 'М. Метро',
            icon: Icons.train,
          ),
        ],
      ),
    );
  }

  Widget _buildComponentCard(
      {required Widget child, EdgeInsetsGeometry? padding}) {
    return AppCard.outlined(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildComponentLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildCardsSection() {
    return Column(
      children: [
        _buildComponentLabel('Default (с рамкой)'),
        const SizedBox(height: 8),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Заголовок карточки',
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Это карточка с рамкой по умолчанию',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentLabel('Outlined (только рамка)'),
        const SizedBox(height: 8),
        AppCard.outlined(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Заголовок карточки',
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Это карточка с рамкой',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentLabel('Elevated (с тенью)'),
        const SizedBox(height: 8),
        AppCard.elevated(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Заголовок карточки',
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Это карточка с тенью',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentLabel('Filled (заливка)'),
        const SizedBox(height: 8),
        AppCard.filled(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Заголовок карточки',
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Это карточка с заливкой',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentLabel('С onTap (кликабельная)'),
        const SizedBox(height: 8),
        AppCard.outlined(
          onTap: () {
            // Обработка клика
          },
          child: Row(
            children: [
              const Icon(Icons.touch_app, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Кликните на карточку',
                  style: AppTextStyles.titleMedium,
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildComponentLabel('С кастомным padding и margin'),
        const SizedBox(height: 8),
        AppCard.outlined(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Карточка с увеличенным padding и margin',
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationBarsSection(DesignSystemViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentLabel('Bottom Fixed Navigation (Material Design 3)'),
        const SizedBox(height: 8),
        _buildComponentCard(
          padding: EdgeInsets.zero,
          child: AppNavigationBar.bottomFixed(
            items: [
              AppNavBarItem(
                icon: Icons.search,
                activeIcon: Icons.search_rounded,
                label: 'Поиск',
              ),
              AppNavBarItem(
                icon: Icons.work_outline,
                activeIcon: Icons.work,
                label: 'Карьера',
              ),
              AppNavBarItem(
                icon: Icons.email_outlined,
                activeIcon: Icons.email,
                label: 'Отклики',
                badge: '3',
              ),
              AppNavBarItem(
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Сообщения',
              ),
              AppNavBarItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Профиль',
              ),
            ],
            currentIndex: model.bottomNavIndex,
            onTap: model.setBottomNavIndex,
            showLabels: true,
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Bottom Fixed без лейблов'),
        const SizedBox(height: 8),
        _buildComponentCard(
          padding: EdgeInsets.zero,
          child: AppNavigationBar.bottomFixed(
            items: [
              AppNavBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Главная',
              ),
              AppNavBarItem(
                icon: Icons.shopping_cart_outlined,
                activeIcon: Icons.shopping_cart,
                label: 'Корзина',
                badge: '2',
              ),
              AppNavBarItem(
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long,
                label: 'Заказы',
              ),
              AppNavBarItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Профиль',
              ),
            ],
            currentIndex: model.bottomNavIndex,
            onTap: model.setBottomNavIndex,
            showLabels: false,
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Bottom Shifting Navigation'),
        const SizedBox(height: 8),
        _buildComponentCard(
          padding: EdgeInsets.zero,
          child: AppNavigationBar.bottomShifting(
            items: [
              AppNavBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Главная',
              ),
              AppNavBarItem(
                icon: Icons.favorite_outline,
                activeIcon: Icons.favorite,
                label: 'Избранное',
              ),
              AppNavBarItem(
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: 'Настройки',
              ),
            ],
            currentIndex: model.bottomShiftingNavIndex,
            onTap: model.setBottomShiftingNavIndex,
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Pill Tabs (Segmented Control)'),
        const SizedBox(height: 8),
        _buildComponentCard(
          child: AppNavigationBar.pillTabs(
            items: [
              AppNavBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Для вас',
              ),
              AppNavBarItem(
                icon: Icons.work_outline,
                activeIcon: Icons.work,
                label: 'Подработка',
              ),
              AppNavBarItem(
                icon: Icons.schedule_outlined,
                activeIcon: Icons.schedule,
                label: 'Вахта',
              ),
            ],
            currentIndex: model.pillTabsIndex,
            onTap: model.setPillTabsIndex,
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Pill Tabs только с иконками'),
        const SizedBox(height: 8),
        _buildComponentCard(
          child: AppNavigationBar.pillTabs(
            items: [
              AppNavBarItem(
                icon: Icons.grid_view_outlined,
                activeIcon: Icons.grid_view,
                label: 'Сетка',
              ),
              AppNavBarItem(
                icon: Icons.view_list_outlined,
                activeIcon: Icons.view_list,
                label: 'Список',
              ),
            ],
            currentIndex: model.pillTabsIndex % 2,
            onTap: (index) => model.setPillTabsIndex(index % 2),
            showLabels: false,
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentLabel('Standard AppBar (слева)'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppAppBar.standard(
              title: 'Заголовок',
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Centered AppBar'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppAppBar.centered(
              title: 'Центрированный заголовок',
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('AppBar с поиском'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppAppBar.withSearch(
              searchField: TextField(
                decoration: InputDecoration(
                  hintText: 'Должность, ключевые слова...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Transparent AppBar'),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppAppBar.transparent(
              title: 'Прозрачный AppBar',
              actions: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Elevated AppBar (с тенью)'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppAppBar.elevated(
              title: 'AppBar с тенью',
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Extended AppBar (удвоенная высота)'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppAppBar.extended(
              title: 'Корзина',
              actions: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {},
                ),
              ],
              bottomWidget: Row(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '4 товара',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '2 450 ₽',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildComponentLabel('Extended AppBar (с дополнительным контентом)'),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppAppBar.extended(
              title: 'Профиль',
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {},
                ),
              ],
              bottomWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Иван Иванов',
                            style: AppTextStyles.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '+7 (999) 123-45-67',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheetsSection() {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComponentLabel('Draggable Bottom Sheet (50% по умолчанию)'),
          const SizedBox(height: 8),
          AppButton.primary(
            label: 'Открыть шторку 50%',
            onPressed: () {
              AppBottomSheet.show(
                context: context,
                title: 'Заголовок шторки',
                initialHeight: AppBottomSheetHeight.medium,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Это draggable bottom sheet',
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Смахивайте вверх/вниз для изменения размера',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: AppColors.textOnPrimary,
                              ),
                            ),
                          ),
                          title: Text('Элемент ${index + 1}'),
                          subtitle: Text('Описание элемента'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildComponentLabel('Draggable Bottom Sheet (80%)'),
          const SizedBox(height: 8),
          AppButton.secondary(
            label: 'Открыть большую шторку',
            onPressed: () {
              AppBottomSheet.show(
                context: context,
                title: 'Большая шторка',
                initialHeight: AppBottomSheetHeight.large,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Большая шторка занимает 80% экрана',
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(
                      15,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: AppColors.textOnPrimary,
                              ),
                            ),
                          ),
                          title: Text('Элемент списка ${index + 1}'),
                          subtitle: Text('Подзаголовок элемента'),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildComponentLabel('Простая шторка (фиксированная высота)'),
          const SizedBox(height: 8),
          AppButton.secondary(
            label: 'Открыть простую шторку',
            onPressed: () {
              AppSimpleBottomSheet.show(
                context: context,
                title: 'Простая шторка',
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Простая шторка с фиксированной высотой',
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Эта шторка не может быть растянута, но можно закрыть свайпом вниз',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton.primary(
                      label: 'Действие 1',
                      onPressed: () {},
                      isFullWidth: true,
                    ),
                    const SizedBox(height: 12),
                    AppButton.secondary(
                      label: 'Действие 2',
                      onPressed: () {},
                      isFullWidth: true,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildComponentLabel('Шторка с действиями в заголовке'),
          const SizedBox(height: 8),
          AppButton.secondary(
            label: 'Шторка с кнопками',
            onPressed: () {
              AppBottomSheet.show(
                context: context,
                title: 'Шторка с действиями',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
                initialHeight: AppBottomSheetHeight.medium,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'В заголовке есть кнопки действий',
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Вы можете добавить любые виджеты в actions',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildComponentLabel('Snap Bottom Sheet (40% ↔ 90%)'),
          const SizedBox(height: 8),
          AppButton.primary(
            label: 'Шторка с snap-позициями',
            onPressed: () {
              AppSnapBottomSheet.showWithSnaps(
                context: context,
                title: 'Шторка с snap-позициями',
                snapSizes: const [0.4, 0.9], // 40% и 90%
                initialSnapIndex: 0, // Начинаем с 40%
                child: Column(
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
                      'Две фиксированные позиции',
                      style: AppTextStyles.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Эта шторка автоматически "прилипает" к позициям 40% и 90%',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(
                      15,
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
                          subtitle: Text('Подзаголовок элемента'),
                          trailing: const Icon(Icons.chevron_right, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsSection(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('Alert Dialog - Success'),
                const SizedBox(height: 8),
                AppButton.primary(
                  label: 'Показать Success',
                  onPressed: () {
                    AppAlertDialog.showSuccess(
                      context,
                      title: 'Успешно!',
                      message: 'Операция выполнена успешно',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('Alert Dialog - Error'),
                const SizedBox(height: 8),
                AppButton.primary(
                  label: 'Показать Error',
                  onPressed: () {
                    AppAlertDialog.showError(
                      context,
                      title: 'Ошибка',
                      message: 'Произошла ошибка при выполнении операции',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('Alert Dialog - Warning'),
                const SizedBox(height: 8),
                AppButton.primary(
                  label: 'Показать Warning',
                  onPressed: () {
                    AppAlertDialog.showWarning(
                      context,
                      title: 'Предупреждение',
                      message: 'Вы уверены, что хотите продолжить?',
                      confirmText: 'Да',
                      cancelText: 'Нет',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('Alert Dialog - Info'),
                const SizedBox(height: 8),
                AppButton.primary(
                  label: 'Показать Info',
                  onPressed: () {
                    AppAlertDialog.showInfo(
                      context,
                      title: 'Информация',
                      message: 'Это информационное сообщение',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('Alert Dialog - Confirm'),
                const SizedBox(height: 8),
                AppButton.primary(
                  label: 'Показать Confirm',
                  onPressed: () {
                    AppAlertDialog.showConfirm(
                      context,
                      title: 'Подтверждение',
                      message: 'Вы уверены, что хотите удалить этот элемент?',
                      confirmText: 'Удалить',
                      cancelText: 'Отмена',
                      onConfirm: () {
                        AppSnackBar.showSuccess(
                          context,
                          message: 'Элемент удален',
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('SnackBar - Success'),
                const SizedBox(height: 8),
                AppButton.secondary(
                  label: 'Показать Success SnackBar',
                  onPressed: () {
                    AppSnackBar.showSuccess(
                      context,
                      message: 'Операция выполнена успешно!',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('SnackBar - Error'),
                const SizedBox(height: 8),
                AppButton.secondary(
                  label: 'Показать Error SnackBar',
                  onPressed: () {
                    AppSnackBar.showError(
                      context,
                      message: 'Произошла ошибка',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('SnackBar - Warning'),
                const SizedBox(height: 8),
                AppButton.secondary(
                  label: 'Показать Warning SnackBar',
                  onPressed: () {
                    AppSnackBar.showWarning(
                      context,
                      message: 'Внимание! Проверьте данные',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildComponentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComponentLabel('SnackBar - Info'),
                const SizedBox(height: 8),
                AppButton.secondary(
                  label: 'Показать Info SnackBar',
                  onPressed: () {
                    AppSnackBar.showInfo(
                      context,
                      message: 'Новая информация доступна',
                      actionLabel: 'Подробнее',
                      onAction: () {
                        AppAlertDialog.showInfo(
                          context,
                          message: 'Это дополнительная информация',
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
