import 'package:dio/dio.dart';

/// Результат разбора ошибки API (HTTP + тело ответа).
class ApiErrorDetails {
  final String message;
  final int? statusCode;
  final String? errorCode;

  const ApiErrorDetails({
    required this.message,
    this.statusCode,
    this.errorCode,
  });
}

/// Извлекает код и текст ошибки из ответа сервера и DioException.
class ApiErrorParser {
  ApiErrorParser._();

  /// Разбор при наличии [Response] (в т.ч. 4xx/5xx с телом JSON).
  static ApiErrorDetails fromResponse(Response<dynamic>? response) {
    final code = response?.statusCode;
    final data = response?.data;

    String? apiError;
    String? apiMessage;

    if (data is Map) {
      final map = Map<String, dynamic>.from(data);
      final err = map['error'];
      if (err != null) {
        apiError = err.toString();
      }
      final msg = map['message'] ?? map['detail'] ?? map['title'];
      if (msg != null) {
        apiMessage = msg.toString();
      }
    } else if (data is String && data.trim().isNotEmpty) {
      apiMessage = data.trim();
    }

    final message = _buildMessage(
      httpCode: code,
      errorField: apiError,
      detail: apiMessage,
    );

    return ApiErrorDetails(
      message: message,
      statusCode: code,
      errorCode: apiError,
    );
  }

  /// Разбор [DioException] (сеть, таймаут, 5xx как исключение и т.д.).
  static ApiErrorDetails fromDioException(DioException e) {
    if (e.response != null) {
      return fromResponse(e.response);
    }

    final fallback = e.error?.toString();
    final msg = (fallback != null && fallback.isNotEmpty)
        ? fallback
        : (e.message ?? 'Ошибка сети');

    return ApiErrorDetails(
      message: msg,
      statusCode: null,
      errorCode: null,
    );
  }

  static String _buildMessage({
    required int? httpCode,
    String? errorField,
    String? detail,
  }) {
    final parts = <String>[];
    if (httpCode != null) {
      parts.add('HTTP $httpCode');
    }
    if (errorField != null && errorField.isNotEmpty) {
      parts.add(errorField);
    }
    if (detail != null && detail.isNotEmpty) {
      parts.add(detail);
    }
    if (parts.isEmpty) {
      return 'Ошибка запроса';
    }
    return parts.join(' · ');
  }
}
