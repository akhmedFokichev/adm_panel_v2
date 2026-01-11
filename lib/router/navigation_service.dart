import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adm_panel_v2/router/app_router.dart';

/// Сервис для навигации (обертка над go_router)
/// Поддерживает два способа работы:
/// 1. Через routerKey (рекомендуется) - работает без BuildContext
/// 2. Через BuildContext (fallback) - для совместимости
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService({GlobalKey<NavigatorState>? navigatorKey}) {
    if (navigatorKey != null) {
      _instance._navigatorKey = navigatorKey;
    }
    return _instance;
  }
  NavigationService._internal();

  BuildContext? _context;
  GlobalKey<NavigatorState>? _navigatorKey;

  /// Установить контекст для навигации (fallback метод)
  void setContext(BuildContext context) {
    _context = context;
  }

  /// Получить текущий контекст
  BuildContext? get context => _context;

  /// Получить контекст из routerKey или установленный контекст
  BuildContext? get _effectiveContext {
    if (_navigatorKey?.currentContext != null) {
      return _navigatorKey!.currentContext;
    }
    return _context;
  }

  /// Перейти на маршрут (заменяет текущий маршрут)
  void go(String path) {
    _effectiveContext?.go(path);
  }

  /// Перейти на именованный маршрут
  void goNamed(String name,
      {Map<String, String>? pathParameters,
      Map<String, dynamic>? queryParameters}) {
    final ctx = _effectiveContext;
    if (ctx != null) {
      ctx.goNamed(
        name,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {},
      );
    }
  }

  /// Перейти на новый маршрут (добавляет в стек)
  void push(String path) {
    _effectiveContext?.push(path);
  }

  /// Перейти на новый маршрут и получить результат (колбэк)
  ///
  /// [path] - путь к маршруту
  ///
  /// Возвращает Future с результатом, который вернет экран через pop(result)
  ///
  /// Пример использования:
  /// ```dart
  /// final result = await navigationService.pushForResult<String>('/address-search');
  /// if (result != null) {
  ///   print('Выбранный адрес: $result');
  /// }
  /// ```
  Future<T?> pushForResult<T>(String path) async {
    final ctx = _effectiveContext;
    if (ctx != null) {
      return await ctx.push<T>(path);
    }
    return null;
  }

  /// Перейти на именованный маршрут (добавляет в стек)
  void pushNamed(String name,
      {Map<String, String>? pathParameters,
      Map<String, dynamic>? queryParameters}) {
    final ctx = _effectiveContext;
    if (ctx != null) {
      ctx.pushNamed(
        name,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {},
      );
    }
  }

  /// Перейти на именованный маршрут и получить результат (колбэк)
  ///
  /// [name] - имя маршрута
  /// [pathParameters] - параметры пути
  /// [queryParameters] - query параметры
  ///
  /// Возвращает Future с результатом, который вернет экран через pop(result)
  ///
  /// Пример использования:
  /// ```dart
  /// final address = await navigationService.pushNamedForResult<AddressResult>(
  ///   'addressSearch',
  /// );
  /// ```
  Future<T?> pushNamedForResult<T>(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
  }) async {
    final ctx = _effectiveContext;
    if (ctx != null) {
      return await ctx.pushNamed<T>(
        name,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {},
      );
    }
    return null;
  }

  /// Вернуться назад
  void pop<T>([T? result]) {
    final ctx = _effectiveContext;
    if (ctx != null && ctx.canPop()) {
      ctx.pop(result);
    }
  }

  /// Вернуться назад и заменить текущий маршрут
  void popAndPush(String path) {
    final ctx = _effectiveContext;
    if (ctx != null && ctx.canPop()) {
      ctx.pop();
      ctx.push(path);
    } else {
      ctx?.push(path);
    }
  }

  /// Заменить текущий маршрут
  void replace(String path) {
    _effectiveContext?.replace(path);
  }

  // Удобные методы для конкретных маршрутов
  void goToSplash() => go(AppRouter.splash);
  void goToPhoneInput() => go(AppRouter.phoneInput);
  void goToSmsCode(String phone) =>
      go('${AppRouter.smsCode}?phone=${Uri.encodeComponent(phone)}');
  void goToMain() => go(AppRouter.main);
  void goToHome() => go(AppRouter.home);
  void goToOrders() => go(AppRouter.orders);
  void goToCart() => go(AppRouter.cart);
  void goToProfile() => go(AppRouter.profile);
  void goToDesignSystem() => go(AppRouter.designSystem);
  void goToMap() => go(AppRouter.map);
  void goToList() => go(AppRouter.floatingPanelList);
  void goToAddressSearch() => go(AppRouter.addressSearch);
  void goToSelectAddress() => push(AppRouter.selectAddress);
  void goToMyAddresses() => go(AppRouter.myAddresses);
  void goToLogin() => go(AppRouter.login);

  /// Открыть экран поиска адреса и получить результат (колбэк)
  ///
  /// Возвращает Future с выбранным адресом или null, если пользователь закрыл экран
  ///
  /// Пример использования:
  /// ```dart
  /// final address = await _navigationService.goToAddressSearchForResult();
  /// if (address != null) {
  ///   print('Выбранный адрес: ${address.address}');
  /// }
  /// ```
  Future<T?> goToSelectAddressForResult<T>() async {
    return await pushNamedForResult<T>('selectAddress');
  }
}
