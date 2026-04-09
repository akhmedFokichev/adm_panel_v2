import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_alert_dialog.dart';
import 'package:adm_panel_v2/design/app_button.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_switch.dart';
import 'package:adm_panel_v2/design/app_tab_switch.dart';
import 'package:adm_panel_v2/design/app_text_style.dart';
import 'package:adm_panel_v2/design/app_text_field.dart';

class AdminDesignSystemPage extends StatelessWidget {
  const AdminDesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Design System',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const _SectionCard(
            title: 'Палитра',
            child: _PaletteTable(),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Шрифты и размеры',
            child: SizedBox(
              width: 520,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TypographyRow(
                    token: 'AppTextStyle.h1.value',
                    sample: 'H1 Заголовок',
                    style: AppTextStyle.h1.value,
                  ),
                  SizedBox(height: 12),
                  _TypographyRow(
                    token: 'AppTextStyle.h2.value',
                    sample: 'H2 Заголовок',
                    style: AppTextStyle.h2.value,
                  ),
                  SizedBox(height: 12),
                  _TypographyRow(
                    token: 'AppTextStyle.h3.value',
                    sample: 'H3 Заголовок',
                    style: AppTextStyle.h3.value,
                  ),
                  SizedBox(height: 12),
                  _TypographyRow(
                    token: 'AppTextStyle.h4.value',
                    sample: 'H4 Заголовок',
                    style: AppTextStyle.h4.value,
                  ),
                  SizedBox(height: 12),
                  _TypographyRow(
                    token: 'AppTextStyle.bodyLarge.value',
                    sample: 'Body Large — основной текст 16',
                    style: AppTextStyle.bodyLarge.value,
                  ),
                  SizedBox(height: 12),
                  _TypographyRow(
                    token: 'AppTextStyle.body.value',
                    sample: 'Body — основной текст 14',
                    style: AppTextStyle.body.value,
                  ),
                  SizedBox(height: 12),
                  _TypographyRow(
                    token: 'AppTextStyle.bodySmall.value',
                    sample: 'Body Small — компактный текст 13',
                    style: AppTextStyle.bodySmall.value,
                  ),
                  SizedBox(height: 12),
                  _TypographyRow(
                    token: 'AppTextStyle.caption.value',
                    sample: 'Caption — подпись 12',
                    style: AppTextStyle.caption.value,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Кнопки',
            child: SizedBox(
              width: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _CodeClassName('AppButton'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      const AppButton(label: 'Primary'),
                      const AppButton(
                        label: 'Outlined',
                        variant: AppButtonVariant.outlined,
                      ),
                      const AppButton(
                        label: 'Text',
                        variant: AppButtonVariant.text,
                      ),
                      const AppButton(
                        label: 'Compact',
                        size: AppButtonSize.compact,
                      ),
                      const AppButton(
                        label: 'Loading',
                        isLoading: true,
                      ),
                      AppButton(
                        label: 'Показать Alert',
                        onPressed: () => _showPreviewDialog(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _SectionCard(
            title: 'Компоненты ввода',
            child: SizedBox(
              width: 420,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CodeClassName('AppTextField'),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: 'Обычное поле',
                    hintText: 'Введите текст',
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    obscureText: true,
                    labelText: 'Пароль',
                    hintText: 'Введите пароль',
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    enabled: false,
                    labelText: 'Disabled',
                    hintText: 'Поле недоступно',
                  ),
                  SizedBox(height: 12),
                  AppTextField(
                    minLines: 3,
                    maxLines: 5,
                    labelText: 'Multiline',
                    hintText: 'Многострочный ввод',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _SectionCard(
            title: 'Switch / TabSwitch',
            child: _SwitchesDemo(),
          ),
        ],
      ),
    );
  }

  Future<void> _showPreviewDialog(BuildContext context) async {
    await AppAlertDialog.showMessage<void>(
      context,
      title: 'Превью диалога',
      message: 'Экран Design System подключен в меню.',
      variant: AppAlertDialogVariant.info,
      primaryLabel: 'OK',
      showCloseButton: true,
      barrierDismissible: true,
    );
  }
}

class _SwitchesDemo extends StatefulWidget {
  const _SwitchesDemo();

  @override
  State<_SwitchesDemo> createState() => _SwitchesDemoState();
}

class _SwitchesDemoState extends State<_SwitchesDemo> {
  bool _enabled = true;
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CodeClassName('AppSwitch'),
          AppSwitch(
            value: _enabled,
            label: 'Уведомления',
            onChanged: (value) {
              setState(() {
                _enabled = value;
              });
            },
          ),
          const SizedBox(height: 12),
          const _CodeClassName('AppTabSwitch'),
          const SizedBox(height: 8),
          AppTabSwitch(
            tabs: const ['Список', 'Карточки', 'Таблица'],
            selectedIndex: _selectedTab,
            onChanged: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
          ),
          const SizedBox(height: 10),
          Text(
            'Текущий таб: ${_selectedTab + 1}',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _PaletteTable extends StatelessWidget {
  const _PaletteTable();

  static const List<({String token, Color color})> _tokens = [
    (token: 'AppColors.primary', color: AppColors.primary),
    (token: 'AppColors.primaryDark', color: AppColors.primaryDark),
    (token: 'AppColors.primaryLight', color: AppColors.primaryLight),
    (token: 'AppColors.background', color: AppColors.background),
    (token: 'AppColors.backgroundAdmin', color: AppColors.backgroundAdmin),
    (token: 'AppColors.surface', color: AppColors.surface),
    (token: 'AppColors.surfaceVariant', color: AppColors.surfaceVariant),
    (token: 'AppColors.surfaceDark', color: AppColors.surfaceDark),
    (token: 'AppColors.sidebarBackground', color: AppColors.sidebarBackground),
    (token: 'AppColors.sidebarItemActive', color: AppColors.sidebarItemActive),
    (token: 'AppColors.sidebarDivider', color: AppColors.sidebarDivider),
    (token: 'AppColors.textPrimary', color: AppColors.textPrimary),
    (token: 'AppColors.textPrimaryMuted', color: AppColors.textPrimaryMuted),
    (token: 'AppColors.textSecondary', color: AppColors.textSecondary),
    (token: 'AppColors.textTertiary', color: AppColors.textTertiary),
    (token: 'AppColors.textOnPrimary', color: AppColors.textOnPrimary),
    (token: 'AppColors.transparent', color: AppColors.transparent),
    (token: 'AppColors.error', color: AppColors.error),
    (token: 'AppColors.success', color: AppColors.success),
    (token: 'AppColors.warning', color: AppColors.warning),
    (token: 'AppColors.info', color: AppColors.info),
    (token: 'AppColors.border', color: AppColors.border),
    (token: 'AppColors.divider', color: AppColors.divider),
    (token: 'AppColors.shadowLight', color: AppColors.shadowLight),
    (token: 'AppColors.shadowMedium', color: AppColors.shadowMedium),
    (token: 'AppColors.shadowDark', color: AppColors.shadowDark),
  ];

  String _hex(Color color) {
    int ch(double v) => (v * 255).round().clamp(0, 255);
    final a = ch(color.a).toRadixString(16).padLeft(2, '0');
    final r = ch(color.r).toRadixString(16).padLeft(2, '0');
    final g = ch(color.g).toRadixString(16).padLeft(2, '0');
    final b = ch(color.b).toRadixString(16).padLeft(2, '0');
    return '#${(a + r + g + b).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Token')),
          DataColumn(label: Text('Preview')),
          DataColumn(label: Text('Hex')),
        ],
        rows: _tokens
            .map(
              (item) => DataRow(
                cells: [
                  DataCell(Text(item.token)),
                  DataCell(
                    Container(
                      width: 56,
                      height: 24,
                      decoration: BoxDecoration(
                        color: item.color,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  DataCell(Text(_hex(item.color))),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TypographyRow extends StatelessWidget {
  final String token;
  final String sample;
  final TextStyle style;

  const _TypographyRow({
    required this.token,
    required this.sample,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            token,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            sample,
            style: style,
          ),
        ),
      ],
    );
  }
}

class _CodeClassName extends StatelessWidget {
  final String className;

  const _CodeClassName(this.className);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        className,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
