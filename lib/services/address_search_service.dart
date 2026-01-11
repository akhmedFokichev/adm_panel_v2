import 'dart:convert'; // Добавьте импорт для jsonDecode
import 'package:dio/dio.dart';
import 'package:adm_panel_v2/network/models/requests/address_search_request.dart';
import 'package:adm_panel_v2/network/models/responses/address_search_response.dart';

import '../core/network/api_response.dart';
import '../core/services/api_service.dart';

class AddressSearchService extends ApiService {
  // Для Yandex API нужен отдельный клиент с другим baseUrl
  final Dio yandexDio;

  AddressSearchService(super.apiClient)
      : yandexDio = Dio(
    BaseOptions(
      baseUrl: 'https://geocode-maps.yandex.ru',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      // Важно: указываем, что ожидаем JSON
      responseType: ResponseType.json,
    ),
  );

  /// Поиск адреса через Yandex Geocoder API
  Future<ApiResponse<AddressSearchResponse>> search({
    required AddressSearchRequest request,
    required String apiKey,
  }) async {
    // Проверка на пустой запрос
    if (request.geocode.trim().isEmpty) {
      print('⚠️ Пустой запрос geocode - пропускаем');
      return ApiResponse.error('Запрос не может быть пустым', 400);
    }

    // Проверка минимальной длины (опционально, но рекомендуется)
    if (request.geocode.trim().length < 2) {
      print('⚠️ Слишком короткий запрос (меньше 2 символов) - пропускаем');
      return ApiResponse.error('Введите минимум 2 символа', 400);
    }

    try {
      final queryParams = request.toQueryParams();
      queryParams['apikey'] = apiKey;
      queryParams['format'] = 'json'; // Явно указываем формат JSON

      // Детальное логирование запроса
      print('🔍 ========== Yandex Geocoder Request ==========');
      print('📍 Base URL: https://geocode-maps.yandex.ru');
      print('📍 Path: /1.x/');
      print('📋 Query Parameters:');
      queryParams.forEach((key, value) {
        print('   $key: $value');
      });
      print('🔍 ============================================');

      // Убираем типизацию <Map<String, dynamic>> - получаем Response<dynamic>
      final response = await yandexDio.get(
        '/1.x/',
        queryParameters: queryParams,
      );

      print('✅ ========== Yandex Geocoder Response ==========');
      print('📊 Status Code: ${response.statusCode}');
      print('📦 Response Type: ${response.data.runtimeType}');
      print('📦 Response Data: ${response.data}');
      print('✅ ============================================');

      // Парсим ответ вручную
      Map<String, dynamic> responseData;

      if (response.data != null) {
        if (response.data is Map<String, dynamic>) {
          // Уже Map - используем как есть
          responseData = response.data as Map<String, dynamic>;
        } else if (response.data is String) {
          // Строка - парсим JSON
          print('📝 Парсим JSON из строки...');
          try {
            responseData = jsonDecode(response.data as String) as Map<String, dynamic>;
            print('✅ JSON успешно распарсен');
          } catch (e) {
            print('❌ Ошибка парсинга JSON: $e');
            print('❌ Сырая строка: ${response.data}');
            return ApiResponse.error('Ошибка парсинга JSON ответа: $e', 500);
          }
        } else {
          print('❌ Неожиданный тип данных: ${response.data.runtimeType}');
          return ApiResponse.error('Неожиданный формат ответа: ${response.data.runtimeType}', 500);
        }

        try {
          final addressResponse = AddressSearchResponse.fromJson(responseData);
          print('✅ Данные успешно преобразованы в AddressSearchResponse');
          return ApiResponse.success(addressResponse);
        } catch (e, stackTrace) {
          print('❌ ========== Parsing Error ==========');
          print('❌ Error: $e');
          print('❌ StackTrace: $stackTrace');
          print('❌ Raw Data: $responseData');
          print('❌ ====================================');
          return ApiResponse.error('Ошибка парсинга ответа: $e', 500);
        }
      }

      return ApiResponse.error('Пустой ответ от сервера', response.statusCode ?? 500);
    } on DioException catch (e, stackTrace) {
      print('❌ ========== DioException ==========');
      print('❌ Type: ${e.type}');
      print('❌ Message: ${e.message}');
      print('❌ Error: ${e.error}');
      print('❌ Request Options:');
      print('   Method: ${e.requestOptions.method}');
      print('   URI: ${e.requestOptions.uri}');
      print('   Headers: ${e.requestOptions.headers}');
      print('❌ StackTrace: $stackTrace');

      String message = 'Ошибка сети';
      int statusCode = 500;

      if (e.response != null) {
        statusCode = e.response!.statusCode ?? 500;
        final data = e.response!.data;
        final headers = e.response!.headers;

        print('❌ Response Status Code: $statusCode');
        print('❌ Response Headers: $headers');
        print('❌ Response Data Type: ${data.runtimeType}');
        print('❌ Response Data: $data');

        // Парсим данные ответа, если это строка
        dynamic parsedData = data;
        if (data is String) {
          try {
            parsedData = jsonDecode(data);
            print('✅ Ответ распарсен из строки');
          } catch (e) {
            print('⚠️ Не удалось распарсить ответ: $e');
          }
        }

        if (parsedData is Map<String, dynamic>) {
          message = parsedData['message'] as String? ??
              parsedData['error'] as String? ??
              parsedData['error_message'] as String? ??
              parsedData['description'] as String? ??
              'Ошибка сервера (код: $statusCode)';

          print('❌ Response Data Keys: ${parsedData.keys.toList()}');
        } else if (data is String) {
          message = data;
          print('❌ Response Data (String): $data');
        } else {
          message = 'Ошибка сервера (код: $statusCode)';
        }

        // Специфичные сообщения для кодов ошибок
        switch (statusCode) {
          case 400:
            message = 'Неверный запрос (400). Проверьте параметры: $message';
            break;
          case 401:
            message = 'Неверный API ключ (401). Проверьте yandexApiKey';
            break;
          case 403:
            message = 'Доступ запрещен (403). Проверьте права API ключа';
            break;
          case 404:
            message = 'Эндпоинт не найден (404)';
            break;
          case 429:
            message = 'Превышен лимит запросов (429). Попробуйте позже';
            break;
          case 500:
            message = 'Ошибка сервера (500)';
            break;
        }
      } else {
        // Нет ответа от сервера - это проблема сети
        print('❌ Нет ответа от сервера');
        print('❌ DioExceptionType: ${e.type}');

        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            message = 'Таймаут подключения (не удалось подключиться за 30 секунд)';
            statusCode = 408;
            print('❌ Причина: Таймаут подключения');
            break;
          case DioExceptionType.sendTimeout:
            message = 'Таймаут отправки данных';
            statusCode = 408;
            print('❌ Причина: Таймаут отправки');
            break;
          case DioExceptionType.receiveTimeout:
            message = 'Таймаут получения данных (не получили ответ за 30 секунд)';
            statusCode = 408;
            print('❌ Причина: Таймаут получения');
            break;
          case DioExceptionType.badResponse:
            message = 'Неверный ответ от сервера';
            statusCode = 502;
            print('❌ Причина: Неверный ответ');
            break;
          case DioExceptionType.cancel:
            message = 'Запрос отменен';
            statusCode = 499;
            print('❌ Причина: Запрос отменен');
            break;
          case DioExceptionType.connectionError:
            message = 'Ошибка подключения к серверу (проверьте интернет)';
            statusCode = 503;
            print('❌ Причина: Ошибка подключения');
            print('❌ Error: ${e.error}');
            break;
          case DioExceptionType.badCertificate:
            message = 'Ошибка сертификата';
            statusCode = 526;
            print('❌ Причина: Ошибка сертификата');
            break;
          case DioExceptionType.unknown:
            message = 'Неизвестная ошибка сети: ${e.message ?? e.error?.toString() ?? "Неизвестная ошибка"}';
            statusCode = 500;
            print('❌ Причина: Неизвестная ошибка');
            print('❌ Error: ${e.error}');
            break;
        }
      }

      print('❌ Final Error Message: $message');
      print('❌ Final Status Code: $statusCode');
      print('❌ ============================================');

      return ApiResponse.error(message, statusCode);
    } catch (e, stackTrace) {
      print('❌ ========== Unexpected Error ==========');
      print('❌ Error: $e');
      print('❌ StackTrace: $stackTrace');
      print('❌ =======================================');
      return ApiResponse.error('Неизвестная ошибка: ${e.toString()}', 500);
    }
  }
}