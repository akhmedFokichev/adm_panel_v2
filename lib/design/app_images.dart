import 'package:flutter/material.dart';

class AppImages {
  AppImages._();

  // Base paths
  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';

  // Images
  static const String logo = '$_imagesPath/logo.png';
  static const String logoDark = '$_imagesPath/logo_dark.png';
  static const String placeholder = '$_imagesPath/placeholder.png';
  static const String errorImage = '$_imagesPath/error.png';
  static const String emptyState = '$_imagesPath/empty_state.png';
  static const String onboarding1 = '$_imagesPath/onboarding_1.png';
  static const String onboarding2 = '$_imagesPath/onboarding_2.png';
  static const String onboarding3 = '$_imagesPath/onboarding_3.png';

  // Icons
  static const String iconHome = '$_iconsPath/home.svg';
  static const String iconProfile = '$_iconsPath/profile.svg';
  static const String iconCart = '$_iconsPath/cart.svg';
  static const String iconOrders = '$_iconsPath/orders.svg';
  static const String iconSearch = '$_iconsPath/search.svg';
  static const String iconNotification = '$_iconsPath/notification.svg';
  static const String iconSettings = '$_iconsPath/settings.svg';
  static const String iconFavorite = '$_iconsPath/favorite.svg';
  static const String iconLocation = '$_iconsPath/location.svg';
  static const String iconDelivery = '$_iconsPath/delivery.svg';
  static const String iconPayment = '$_iconsPath/payment.svg';
  static const String iconSupport = '$_iconsPath/support.svg';
}

class AppIcons {
  AppIcons._();

  // Material Icons - можно использовать готовые иконки из Material Design
  static const IconData home = Icons.home;
  static const IconData homeFilled = Icons.home_rounded;
  static const IconData profile = Icons.person;
  static const IconData profileFilled = Icons.person_rounded;
  static const IconData cart = Icons.shopping_cart;
  static const IconData cartFilled = Icons.shopping_cart_rounded;
  static const IconData orders = Icons.receipt_long;
  static const IconData ordersFilled = Icons.receipt_long_rounded;
  static const IconData search = Icons.search;
  static const IconData notification = Icons.notifications;
  static const IconData notificationFilled = Icons.notifications_rounded;
  static const IconData settings = Icons.settings;
  static const IconData settingsFilled = Icons.settings_rounded;
  static const IconData favorite = Icons.favorite;
  static const IconData favoriteBorder = Icons.favorite_border;
  static const IconData location = Icons.location_on;
  static const IconData locationFilled = Icons.location_on_rounded;
  static const IconData delivery = Icons.local_shipping;
  static const IconData deliveryFilled = Icons.local_shipping_rounded;
  static const IconData payment = Icons.payment;
  static const IconData paymentFilled = Icons.payment_rounded;
  static const IconData support = Icons.support_agent;
  static const IconData supportFilled = Icons.support_agent_rounded;

  // Common Icons
  static const IconData arrowBack = Icons.arrow_back;
  static const IconData arrowForward = Icons.arrow_forward;
  static const IconData arrowUp = Icons.arrow_upward;
  static const IconData arrowDown = Icons.arrow_downward;
  static const IconData close = Icons.close;
  static const IconData check = Icons.check;
  static const IconData add = Icons.add;
  static const IconData remove = Icons.remove;
  static const IconData edit = Icons.edit;
  static const IconData delete = Icons.delete;
  static const IconData share = Icons.share;
  static const IconData more = Icons.more_vert;
  static const IconData menu = Icons.menu;
  static const IconData filter = Icons.filter_list;
  static const IconData sort = Icons.sort;
  static const IconData refresh = Icons.refresh;
  static const IconData star = Icons.star;
  static const IconData starBorder = Icons.star_border;
  static const IconData starHalf = Icons.star_half;

  // Status Icons
  static const IconData success = Icons.check_circle;
  static const IconData error = Icons.error;
  static const IconData warning = Icons.warning;
  static const IconData info = Icons.info;

  // Transport Icons
  static const IconData electricScooter = Icons.electric_scooter;
  static const IconData bus = Icons.directions_bus;
  static const IconData sports = Icons.sports;
  static const IconData train = Icons.train;
  static const IconData walk = Icons.directions_walk;

  // Navigation Icons
  static const IconData chevronLeft = Icons.chevron_left;
  static const IconData chevronRight = Icons.chevron_right;
  static const IconData expandMore = Icons.expand_more;
  static const IconData expandLess = Icons.expand_less;
}

class AppImageHelper {
  AppImageHelper._();

  /// Загружает изображение с обработкой ошибок
  static Widget image({
    required String path,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    String? placeholder,
    String? errorImage,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          errorImage ?? AppImages.errorImage,
          width: width,
          height: height,
          fit: fit,
        );
      },
    );
  }

  /// Загружает изображение из сети с обработкой ошибок
  static Widget networkImage({
    required String url,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    String? placeholder,
    String? errorImage,
  }) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          errorImage ?? AppImages.errorImage,
          width: width,
          height: height,
          fit: fit,
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return frame == null
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : child;
      },
    );
  }
}
