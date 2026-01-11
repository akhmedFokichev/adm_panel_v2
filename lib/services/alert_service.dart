import 'package:flutter/material.dart';
import 'package:adm_panel_v2/components/app_alert_dialog.dart';
import 'package:adm_panel_v2/components/app_snack_bar.dart';
import 'package:adm_panel_v2/router/app_router.dart';

/// Сервис для показа алертов и уведомлений из ViewModel
/// Использует routerKey для получения контекста без необходимости передавать BuildContext
class AlertService {
  static final AlertService _instance = AlertService._internal();
  factory AlertService() => _instance;
  AlertService._internal();

  GlobalKey<NavigatorState>? _navigatorKey;

  /// Инициализировать сервис с routerKey
  void initialize({GlobalKey<NavigatorState>? navigatorKey}) {
    _navigatorKey = navigatorKey ?? AppRouter.navigatorKey;
  }

  /// Получить контекст из routerKey
  BuildContext? get _context {
    return _navigatorKey?.currentContext;
  }

  /// Показать диалог успеха
  void showSuccess({
    required String message,
    String title = 'Успешно',
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return;
    }

    AppAlertDialog.showSuccess(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
    );
  }

  /// Показать диалог ошибки
  void showError({
    required String message,
    String title = 'Ошибка',
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return;
    }

    AppAlertDialog.showError(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
    );
  }

  /// Показать диалог предупреждения
  void showWarning({
    required String message,
    String title = 'Предупреждение',
    String confirmText = 'OK',
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return;
    }

    AppAlertDialog.showWarning(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Показать информационный диалог
  void showInfo({
    required String message,
    String title = 'Информация',
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return;
    }

    AppAlertDialog.showInfo(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
    );
  }

  /// Показать диалог подтверждения
  /// Возвращает Future<bool?> - true если подтверждено, false если отменено, null если закрыто
  Future<bool?> showConfirm({
    required String title,
    required String message,
    String confirmText = 'Подтвердить',
    String cancelText = 'Отмена',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return null;
    }

    return await AppAlertDialog.showConfirm(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  /// Показать SnackBar успеха
  void showSuccessSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return;
    }

    AppSnackBar.showSuccess(
      context,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Показать SnackBar ошибки
  void showErrorSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return;
    }

    AppSnackBar.showError(
      context,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Показать SnackBar предупреждения
  void showWarningSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return;
    }

    AppSnackBar.showWarning(
      context,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Показать информационный SnackBar
  void showInfoSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final context = _context;
    if (context == null) {
      print('⚠️ AlertService: Context недоступен. Убедитесь, что сервис инициализирован.');
      return;
    }

    AppSnackBar.showInfo(
      context,
      message: message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}

