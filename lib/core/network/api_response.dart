/// Обертка для ответов API
class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  /// HTTP статус (при успехе и при ошибке с ответом сервера).
  final int? statusCode;
  /// Код/тип ошибки из тела ответа (например поле `error` в JSON).
  final String? errorCode;

  ApiResponse({
    this.data,
    this.message,
    required this.success,
    this.statusCode,
    this.errorCode,
  });

  /// Успешный ответ
  factory ApiResponse.success(T data, [int? statusCode]) {
    return ApiResponse<T>(
      data: data,
      success: true,
      statusCode: statusCode,
    );
  }

  /// Ответ с ошибкой (HTTP и/или бизнес-ошибка API)
  factory ApiResponse.error(
    String message, [
    int? statusCode,
    String? errorCode,
  ]) {
    return ApiResponse<T>(
      message: message,
      success: false,
      statusCode: statusCode,
      errorCode: errorCode,
    );
  }
}
