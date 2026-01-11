/// Универсальный ответ от API
class ApiResponse<T> {
  final T? data;
  final String? message;
  final int statusCode;

  ApiResponse({
    this.data,
    this.message,
    this.statusCode = -1, // Добавлено значение по умолчанию
  });

  /// Создать успешный ответ
  factory ApiResponse.success(T data, {String? message, int statusCode = 200}) {
    return ApiResponse<T>(
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  /// Создать ответ с ошибкой
  factory ApiResponse.error(String message, int statusCode) {
    return ApiResponse<T>(
      message: message,
      statusCode: statusCode,
    );
  }
}
