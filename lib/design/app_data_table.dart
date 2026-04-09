import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_style.dart';

/// Общий стиль [DataTable]: фон шапки, типографика, сетка с линиями
/// (внешняя рамка, вертикали между колонками, горизонталь под шапкой и между строками).
class AppDataTable {
  AppDataTable._();

  static const BorderSide _outer = BorderSide(color: AppColors.border, width: 1);
  static const BorderSide _inner = BorderSide(color: AppColors.divider, width: 1);

  /// Линии таблицы: рамка и разделители ячеек (шапка отделена от тела первой горизонталью).
  static const TableBorder border = TableBorder(
    top: _outer,
    left: _outer,
    right: _outer,
    bottom: _outer,
    horizontalInside: _inner,
    verticalInside: _inner,
  );

  static DataTableThemeData get themeData {
    return DataTableThemeData(
      headingRowColor: WidgetStateProperty.all(AppColors.surfaceVariant),
      headingTextStyle: AppTextStyle.tableHeader.value,
      dataTextStyle: AppTextStyle.tableCell.value.copyWith(fontSize: 14),
      dividerThickness: 0,
      horizontalMargin: 16,
      columnSpacing: 20,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }

  /// Оборачивает виджет (например [SingleChildScrollView] с [DataTable]) и задаёт тему таблицы.
  static Widget themed({
    required BuildContext context,
    required Widget child,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        dataTableTheme: themeData,
      ),
      child: child,
    );
  }
}
