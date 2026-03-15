# Сетевой слой API

## Структура

### Основные компоненты:

1. **ApiClient** - HTTP клиент на основе Dio
   - Поддержка GET, POST, PUT, PATCH, DELETE запросов
   - Автоматическое добавление токена авторизации
   - Обработка ошибок
   - Логирование запросов/ответов

2. **ApiService** - Базовый класс для сервисов API
   - Упрощенная работа с запросами
   - Автоматическая обработка ошибок
   - Поддержка десериализации JSON

3. **Интерцепторы**:
   - `AuthInterceptor` - добавляет токен в заголовки
   - `ErrorInterceptor` - обрабатывает HTTP ошибки
   - `LoggingInterceptor` - логирует запросы/ответы

4. **ApiResponse** - обертка для ответов API
   - Унифицированный формат ответов
   - Поддержка успешных и ошибочных ответов

## Использование

### 1. Создание сервиса

```dart
class MyService extends ApiService {
  MyService(super.apiClient);

  Future<ApiResponse<MyModel>> getData() async {
    return get<MyModel>(
      '/api/data',
      fromJson: (json) => MyModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
```

### 2. Использование в BLoC

```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  final MyService _service;

  MyBloc({MyService? service})
      : _service = service ?? InjectionContainer().myService,
        super(MyInitial()) {
    on<LoadData>(_onLoadData);
  }

  Future<void> _onLoadData(
    LoadData event,
    Emitter<MyState> emit,
  ) async {
    emit(MyLoading());
    
    final response = await _service.getData();
    
    if (response.success && response.data != null) {
      emit(MyLoaded(response.data!));
    } else {
      emit(MyError(response.message ?? 'Ошибка'));
    }
  }
}
```

### 3. Конфигурация

Измените `ApiConfig.baseUrl` на ваш реальный URL API:

```dart
static const String baseUrl = 'https://your-api.com';
```

## Примеры

См. `AuthService` для примера реализации сервиса авторизации.
