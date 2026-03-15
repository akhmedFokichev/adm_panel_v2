import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adm_panel_v2/features/auth/login_auth/login_auth_view.dart';
import 'package:adm_panel_v2/features/splash/splash.dart';
import 'package:adm_panel_v2/features/main/main.dart';
import 'package:adm_panel_v2/features/home/home.dart';
import 'package:adm_panel_v2/features/design_system/design_system.dart';
import 'package:adm_panel_v2/features/map/map.dart';
import 'package:adm_panel_v2/features/address/address.dart';
import 'package:adm_panel_v2/components/app_floating_panel_table_example.dart';
import 'package:adm_panel_v2/services/panel/panel_example.dart';

import '../features/auth/sms_auth/phone_input/phone_input.dart';
import '../features/auth/sms_auth/sms_code/sms_code.dart';
import '../features/admin/dashboard/dashboard.dart';
import '../features/admin/layout/admin_layout.dart';

class AppRouter {
  static const String splash = '/';
  static const String phoneInput = '/auth/phone';
  static const String smsCode = '/auth/sms';
  static const String main = '/main';

  // Корневые маршруты для табов
  static const String home = '/home';
  static const String orders = '/orders';
  static const String cart = '/cart';
  static const String profile = '/profile';

  // Design System
  static const String designSystem = '/design-system';

  // Map
  static const String map = '/map';

  // Address Search
  static const String addressSearch = '/address-search';

  // Select Address
  static const String selectAddress = '/select-address';

  // My Addresses
  static const String myAddresses = '/my-addresses';

  // My Addresses
  static const String login = '/login';

  // Floating Panel Examples
  static const String floatingPanelTable = '/floating-panel/table';
  static const String floatingPanelList = '/floating-panel/list';
  static const String panelServiceExample = '/panel-service/example';

  // Admin Panel Routes
  static const String adminDashboard = '/admin/dashboard';
  static const String adminProducts = '/admin/products';
  static const String adminCategories = '/admin/categories';
  static const String adminOrders = '/admin/orders';
  static const String adminUsers = '/admin/users';
  static const String adminSettings = '/admin/settings';

  // NavigatorKey для NavigationService
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: phoneInput,
        name: 'phoneInput',
        builder: (context, state) => const PhoneInputView(),
      ),
      GoRoute(
        path: smsCode,
        name: 'smsCode',
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          return SmsCodeView(phone: phone);
        },
      ),
      // Главный экран с TabBar
      GoRoute(
        path: main,
        name: 'main',
        builder: (context, state) => const MainView(),
      ),
      // Корневые маршруты для отдельных табов (можно использовать напрямую)
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: orders,
        name: 'orders',
        builder: (context, state) => const OrdersTab(),
      ),
      GoRoute(
        path: cart,
        name: 'cart',
        builder: (context, state) => const CartTab(),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfileTab(),
      ),
      GoRoute(
        path: designSystem,
        name: 'designSystem',
        builder: (context, state) => const DesignSystemView(),
      ),
      GoRoute(
        path: map,
        name: 'map',
        builder: (context, state) => const MapView(),
      ),
      GoRoute(
        path: addressSearch,
        name: 'addressSearch',
        builder: (context, state) => const AddressSearchView(),
      ),
      GoRoute(
        path: selectAddress,
        name: 'selectAddress',
        builder: (context, state) => SelectAddressView(),
      ),
      GoRoute(
        path: myAddresses,
        name: 'myAddresses',
        builder: (context, state) => const MyAddressesView(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => LoginAuthView(),
      ),

      // Floating Panel Examples
      GoRoute(
        path: floatingPanelTable,
        name: 'floatingPanelTable',
        builder: (context, state) => const FloatingPanelTableExample(),
      ),
      GoRoute(
        path: floatingPanelList,
        name: 'floatingPanelList',
        builder: (context, state) => const FloatingPanelListExample(),
      ),
      GoRoute(
        path: panelServiceExample,
        name: 'panelServiceExample',
        builder: (context, state) => const PanelServiceExample(),
      ),

      // Admin Panel Routes
      GoRoute(
        path: adminDashboard,
        name: 'adminDashboard',
        builder: (context, state) => const DashboardView(),
      ),
      // Placeholder routes for other admin pages
      GoRoute(
        path: adminProducts,
        name: 'adminProducts',
        builder: (context, state) => const _PlaceholderView(title: 'Товары'),
      ),
      GoRoute(
        path: adminCategories,
        name: 'adminCategories',
        builder: (context, state) => const _PlaceholderView(title: 'Категории'),
      ),
      GoRoute(
        path: adminOrders,
        name: 'adminOrders',
        builder: (context, state) => const _PlaceholderView(title: 'Заказы'),
      ),
      GoRoute(
        path: adminUsers,
        name: 'adminUsers',
        builder: (context, state) => const _PlaceholderView(title: 'Пользователи'),
      ),
      GoRoute(
        path: adminSettings,
        name: 'adminSettings',
        builder: (context, state) => const _PlaceholderView(title: 'Настройки'),
      ),
    ],
  );
}

// Placeholder для будущих страниц
class _PlaceholderView extends StatelessWidget {
  final String title;

  const _PlaceholderView({required this.title});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: title,
      child: Center(
        child: Text(
          'Страница "$title" в разработке',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
