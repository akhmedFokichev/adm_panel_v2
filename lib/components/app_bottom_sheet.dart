import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

/// Варианты высоты bottom sheet
enum AppBottomSheetHeight {
  small, // ~30% экрана
  medium, // ~50% экрана
  large, // ~80% экрана
  full, // Полный экран
}

/// Material Design 3 стилизованный Bottom Sheet компонент
class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final AppBottomSheetHeight initialHeight;
  final double? minHeight;
  final double? maxHeight;
  final bool isDismissible;
  final bool enableDrag;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool showHandle;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.titleWidget,
    this.actions,
    this.initialHeight = AppBottomSheetHeight.medium,
    this.minHeight,
    this.maxHeight,
    this.isDismissible = true,
    this.enableDrag = true,
    this.backgroundColor,
    this.borderRadius,
    this.showHandle = true,
  }) : assert(
          title != null || titleWidget != null || title == null,
          'Either title or titleWidget can be provided, or both can be null',
        );

  /// Показать bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    AppBottomSheetHeight initialHeight = AppBottomSheetHeight.medium,
    double? minHeight,
    double? maxHeight,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool showHandle = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AppBottomSheet(
        title: title,
        titleWidget: titleWidget,
        actions: actions,
        initialHeight: initialHeight,
        minHeight: minHeight,
        maxHeight: maxHeight,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        showHandle: showHandle,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final calculatedMinHeight = minHeight ?? _getMinHeight(screenHeight);
    final calculatedMaxHeight = maxHeight ?? _getMaxHeight(screenHeight);
    final initialHeight = _getInitialHeight(screenHeight);

    return DraggableScrollableSheet(
      initialChildSize: initialHeight / screenHeight,
      minChildSize: calculatedMinHeight / screenHeight,
      maxChildSize: calculatedMaxHeight / screenHeight,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.surface,
            borderRadius: borderRadius ??
                const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowDark,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle для перетаскивания
              if (showHandle && enableDrag) _buildHandle(),
              // Заголовок
              if (title != null || titleWidget != null) _buildHeader(context),
              // Контент
              Flexible(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (titleWidget != null)
            Expanded(child: titleWidget!)
          else if (title != null)
            Expanded(
              child: Text(
                title!,
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }

  double _getMinHeight(double screenHeight) {
    switch (initialHeight) {
      case AppBottomSheetHeight.small:
        return screenHeight * 0.2;
      case AppBottomSheetHeight.medium:
        return screenHeight * 0.3;
      case AppBottomSheetHeight.large:
        return screenHeight * 0.4;
      case AppBottomSheetHeight.full:
        return screenHeight * 0.5;
    }
  }

  double _getMaxHeight(double screenHeight) {
    switch (initialHeight) {
      case AppBottomSheetHeight.small:
        return screenHeight * 0.5;
      case AppBottomSheetHeight.medium:
        return screenHeight * 0.8;
      case AppBottomSheetHeight.large:
        return screenHeight * 0.95;
      case AppBottomSheetHeight.full:
        return screenHeight;
    }
  }

  double _getInitialHeight(double screenHeight) {
    switch (initialHeight) {
      case AppBottomSheetHeight.small:
        return screenHeight * 0.3;
      case AppBottomSheetHeight.medium:
        return screenHeight * 0.5;
      case AppBottomSheetHeight.large:
        return screenHeight * 0.8;
      case AppBottomSheetHeight.full:
        return screenHeight;
    }
  }
}

/// Bottom Sheet с snap-позициями (фиксированные точки остановки)
class AppSnapBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final List<double> snapSizes; // Размеры в долях от экрана (0.0 - 1.0)
  final int initialSnapIndex; // Начальный индекс snap позиции
  final bool isDismissible;
  final bool enableDrag;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool showHandle;

  AppSnapBottomSheet({
    super.key,
    required this.child,
    required this.snapSizes,
    this.title,
    this.titleWidget,
    this.actions,
    this.initialSnapIndex = 0,
    this.isDismissible = true,
    this.enableDrag = true,
    this.backgroundColor,
    this.borderRadius,
    this.showHandle = true,
  }) : assert(
          snapSizes.isNotEmpty,
          'snapSizes must not be empty',
        );

  /// Показать snap bottom sheet с позициями 40% и 90%
  static Future<T?> showWithSnaps<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    List<double>? snapSizes, // 40% и 90% по умолчанию
    int initialSnapIndex = 0, // Начинаем с первой позиции (40%)
    bool isDismissible = false, // По умолчанию нельзя закрыть
    bool enableDrag = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool showHandle = true,
    bool barrierDismissible = false, // Не закрывается при клике на барьер
    Color? barrierColor, // Прозрачный барьер по умолчанию
  }) {
    final sizes = snapSizes ?? [0.4, 0.9];
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible &&
          barrierDismissible, // Закрывается только если оба true
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor ?? Colors.transparent, // Прозрачный барьер
      isScrollControlled: true,
      builder: (context) => AppSnapBottomSheet(
        title: title,
        titleWidget: titleWidget,
        actions: actions,
        snapSizes: sizes,
        initialSnapIndex: initialSnapIndex,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        showHandle: showHandle,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final minSize = snapSizes.reduce((a, b) => a < b ? a : b);
    final maxSize = snapSizes.reduce((a, b) => a > b ? a : b);
    final clampedIndex = initialSnapIndex.clamp(0, snapSizes.length - 1);
    final initialSize = snapSizes[clampedIndex];

    return DraggableScrollableSheet(
      initialChildSize: initialSize,
      minChildSize: minSize, // Минимум 40% - не может быть меньше
      maxChildSize: maxSize,
      snap: true,
      snapSizes: snapSizes,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.surface,
            borderRadius: borderRadius ??
                const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowDark,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle для перетаскивания
              if (showHandle && enableDrag) _buildHandle(),
              // Заголовок
              if (title != null || titleWidget != null) _buildHeader(context),
              // Контент
              Flexible(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (titleWidget != null)
            Expanded(child: titleWidget!)
          else if (title != null)
            Expanded(
              child: Text(
                title!,
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

/// Упрощенный вариант bottom sheet с фиксированной высотой
class AppSimpleBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final double height;
  final bool isDismissible;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool showHandle;

  const AppSimpleBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.titleWidget,
    this.actions,
    this.height = 400,
    this.isDismissible = true,
    this.backgroundColor,
    this.borderRadius,
    this.showHandle = true,
  });

  /// Показать простой bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    double height = 400,
    bool isDismissible = true,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool showHandle = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppSimpleBottomSheet(
        title: title,
        titleWidget: titleWidget,
        actions: actions,
        height: height,
        isDismissible: isDismissible,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        showHandle: showHandle,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: borderRadius ??
            const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle для перетаскивания
          if (showHandle) _buildHandle(),
          // Заголовок
          if (title != null || titleWidget != null) _buildHeader(context),
          // Контент
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (titleWidget != null)
            Expanded(child: titleWidget!)
          else if (title != null)
            Expanded(
              child: Text(
                title!,
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
