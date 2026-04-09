import 'package:dio/dio.dart';

/// Интерцептор для логирования запросов и ответов (только в debug режиме)
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // В production можно убрать логирование
    print('🚀 REQUEST[${options.method}] => PATH: ${options.path}');
    if (options.queryParameters.isNotEmpty) {
      print('Query Parameters: ${options.queryParameters}');
    }
    if (options.data != null) {
      print('Data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('Type: ${err.type}');
    print('Message: ${err.message}');
    print('Error: ${err.error}');
    if (err.response?.data != null) {
      print('Response data: ${err.response?.data}');
    }
    handler.next(err);
  }
}
