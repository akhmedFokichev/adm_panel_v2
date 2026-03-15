/// Обертка для ответов API
class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  final int? statusCode;

  ApiResponse({
    this.data,
    this.message,
    required this.success,
    this.statusCode,
  });

  /// Успешный ответ
  factory ApiResponse.success(T data, [int? statusCode]) {
    return ApiResponse<T>(
      data: data,
      success: true,
      statusCode: statusCode,
    );
  }

  /// Ответ с ошибкой
  factory ApiResponse.error(String message, [int? statusCode]) {
    return ApiResponse<T>(
      message: message,
      success: false,
      statusCode: statusCode,
    );
  }
}
