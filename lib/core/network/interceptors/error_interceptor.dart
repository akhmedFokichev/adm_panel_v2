import 'package:dio/dio.dart';

/// Интерцептор для обработки ошибок API
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Обработка различных типов ошибок
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        err = err.copyWith(
          error: 'Превышено время ожидания. Проверьте подключение к интернету',
        );
        break;
      case DioExceptionType.badResponse:
        // Обработка HTTP ошибок
        final statusCode = err.response?.statusCode;
        if (statusCode == 401) {
          err = err.copyWith(
            error: 'Необходима авторизация',
          );
        } else if (statusCode == 403) {
          err = err.copyWith(
            error: 'Доступ запрещен',
          );
        } else if (statusCode == 404) {
          err = err.copyWith(
            error: 'Ресурс не найден',
          );
        } else if (statusCode != null && statusCode >= 500) {
          err = err.copyWith(
            error: 'Ошибка сервера. Попробуйте позже',
          );
        }
        break;
      case DioExceptionType.cancel:
        err = err.copyWith(
          error: 'Запрос отменен',
        );
        break;
      case DioExceptionType.unknown:
        err = err.copyWith(
          error: 'Ошибка подключения. Проверьте интернет',
        );
        break;
      default:
        break;
    }
    handler.next(err);
  }
}
