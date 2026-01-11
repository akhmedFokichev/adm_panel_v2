import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';

/// Variants of AppBar
enum AppAppBarVariant {
  standard, // Standard Material Design 3 AppBar
  centered, // Centered title
  withSearch, // AppBar with search field
  transparent, // Transparent background
  elevated, // With elevation/shadow
  extended, // Extended AppBar with double height and bottom content
}

/// Material Design 3 styled AppBar component
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final AppAppBarVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final Widget? searchField;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget?
      bottomWidget; // Additional content below title (for extended variant)

  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.variant = AppAppBarVariant.standard,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.searchField,
    this.showBackButton = true,
    this.onBackPressed,
    this.bottomWidget,
  }) : assert(
          title != null ||
              titleWidget != null ||
              variant == AppAppBarVariant.extended,
          'Either title or titleWidget must be provided (except for extended variant)',
        );

  /// Standard AppBar (Material Design 3)
  const AppAppBar.standard({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.showBackButton = true,
    this.onBackPressed,
  })  : variant = AppAppBarVariant.standard,
        searchField = null,
        bottomWidget = null;

  /// Centered title AppBar
  const AppAppBar.centered({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.showBackButton = true,
    this.onBackPressed,
  })  : variant = AppAppBarVariant.centered,
        searchField = null,
        bottomWidget = null;

  /// AppBar with search field
  const AppAppBar.withSearch({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    required this.searchField,
    this.showBackButton = true,
    this.onBackPressed,
  })  : variant = AppAppBarVariant.withSearch,
        bottomWidget = null;

  /// Transparent AppBar
  const AppAppBar.transparent({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.showBackButton = true,
    this.onBackPressed,
  })  : variant = AppAppBarVariant.transparent,
        searchField = null,
        bottomWidget = null;

  /// Elevated AppBar with shadow
  const AppAppBar.elevated({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.showBackButton = true,
    this.onBackPressed,
  })  : variant = AppAppBarVariant.elevated,
        searchField = null,
        bottomWidget = null;

  /// Extended AppBar with double height and bottom content
  const AppAppBar.extended({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.showBackButton = true,
    this.onBackPressed,
    this.bottomWidget,
  })  : variant = AppAppBarVariant.extended,
        searchField = null;

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor();
    final fgColor = _getForegroundColor();
    final appBarElevation = _getElevation();

    Widget? customLeading = leading;
    if (customLeading == null && automaticallyImplyLeading && showBackButton) {
      // Если есть кастомный callback, используем его
      if (onBackPressed != null) {
        customLeading = IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: fgColor,
          ),
          onPressed: onBackPressed,
        );
      } else if (Navigator.of(context).canPop()) {
        // Если есть возможность вернуться назад, используем стандартное поведение
        customLeading = IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: fgColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        );
      } else {
        // Если нет истории навигации, пытаемся вернуться через go_router
        customLeading = IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: fgColor,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              // Если не можем вернуться, переходим на главный экран
              context.go('/main');
            }
          },
        );
      }
    }

    switch (variant) {
      case AppAppBarVariant.standard:
        return AppBar(
          title: titleWidget ?? (title != null ? Text(title!) : null),
          actions: actions,
          leading: customLeading,
          automaticallyImplyLeading: false,
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: appBarElevation,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w600,
          ),
        );

      case AppAppBarVariant.centered:
        return AppBar(
          title: titleWidget ?? (title != null ? Text(title!) : null),
          actions: actions,
          leading: customLeading,
          automaticallyImplyLeading: false,
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: appBarElevation,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w600,
          ),
        );

      case AppAppBarVariant.withSearch:
        return AppBar(
          title: searchField,
          actions: actions,
          leading: customLeading,
          automaticallyImplyLeading: false,
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: appBarElevation,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        );

      case AppAppBarVariant.transparent:
        return AppBar(
          title: titleWidget ?? (title != null ? Text(title!) : null),
          actions: actions,
          leading: customLeading,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: fgColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w600,
          ),
        );

      case AppAppBarVariant.elevated:
        return AppBar(
          title: titleWidget ?? (title != null ? Text(title!) : null),
          actions: actions,
          leading: customLeading,
          automaticallyImplyLeading: false,
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: appBarElevation ?? 4,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w600,
          ),
        );

      case AppAppBarVariant.extended:
        return Builder(
          builder: (context) {
            final mediaQuery = MediaQuery.of(context);
            final topPadding = mediaQuery.padding.top;
            final totalHeight = kToolbarHeight * 2 + topPadding;

            return Container(
              height: totalHeight,
              decoration: BoxDecoration(
                color: bgColor,
                boxShadow: appBarElevation != null && appBarElevation > 0
                    ? [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: appBarElevation,
                          offset: Offset(0, appBarElevation / 2),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SafeArea padding
                  SizedBox(height: topPadding),
                  // Top section with title and actions
                  SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      children: [
                        if (customLeading != null) customLeading,
                        Expanded(
                          child: titleWidget ??
                              (title != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        title!,
                                        style:
                                            AppTextStyles.titleLarge.copyWith(
                                          color: fgColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink()),
                        ),
                        if (actions != null) ...actions!,
                      ],
                    ),
                  ),
                  // Bottom section with additional content
                  if (bottomWidget != null)
                    SizedBox(
                      height: kToolbarHeight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: bottomWidget,
                        ),
                      ),
                    )
                  else
                    SizedBox(height: kToolbarHeight),
                ],
              ),
            );
          },
        );
    }
  }

  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    switch (variant) {
      case AppAppBarVariant.transparent:
        return Colors.transparent;
      default:
        return AppColors.background;
    }
  }

  Color _getForegroundColor() {
    if (foregroundColor != null) return foregroundColor!;
    return AppColors.textPrimary;
  }

  double? _getElevation() {
    if (elevation != null) return elevation;
    switch (variant) {
      case AppAppBarVariant.elevated:
        return 4;
      case AppAppBarVariant.transparent:
        return 0;
      default:
        return 0;
    }
  }

  @override
  Size get preferredSize {
    if (variant == AppAppBarVariant.extended) {
      // Высота удвоенного AppBar + максимальный возможный SafeArea padding
      // Это гарантирует, что будет достаточно места для всех устройств
      return Size.fromHeight(
          kToolbarHeight * 2 + 60); // 60 - запас для SafeArea
    }
    return const Size.fromHeight(kToolbarHeight);
  }
}
