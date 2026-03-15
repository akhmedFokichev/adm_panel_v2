# Архитектура сетевого слоя API

## Схема работы с API

```mermaid
graph TB
    subgraph "UI Layer"
        A[AuthPage] -->|User Action| B[AuthBloc]
    end
    
    subgraph "BLoC Layer"
        B -->|Event: AuthLoginRequested| C[AuthBloc Handler]
        C -->|Calls| D[AuthService]
    end
    
    subgraph "Service Layer"
        D -->|Extends| E[ApiService]
        E -->|Uses| F[ApiClient]
    end
    
    subgraph "Network Layer"
        F -->|Dio Instance| G[Dio HTTP Client]
        
        subgraph "Interceptors Chain"
            H[LoggingInterceptor] -->|Logs Request| I[AuthInterceptor]
            I -->|Adds Token| J[ErrorInterceptor]
            J -->|Handles Errors| G
        end
        
        G -->|HTTP Request| K[API Server]
        K -->|HTTP Response| G
        G -->|Response| J
        J -->|Processed| I
        I -->|Processed| H
    end
    
    subgraph "Response Flow"
        H -->|ApiResponse| E
        E -->|ApiResponse<T>| D
        D -->|Emit State| B
        B -->|State| A
    end
    
    subgraph "Dependency Injection"
        L[InjectionContainer] -->|Provides| D
        L -->|Manages| F
        L -->|Updates Token| I
    end
    
    style A fill:#e1f5ff
    style B fill:#fff4e1
    style D fill:#e8f5e9
    style F fill:#f3e5f5
    style G fill:#ffebee
    style K fill:#e0f2f1
    style L fill:#fff9c4
```

## Детальная схема компонентов

```mermaid
classDiagram
    class ApiClient {
        +Dio dio
        +get(path, queryParams)
        +post(path, data)
        +put(path, data)
        +delete(path)
        +updateToken(token)
    }
    
    class ApiService {
        <<abstract>>
        +ApiClient apiClient
        +get(path, fromJson)
        +post(path, data, fromJson)
        +put(path, data, fromJson)
        +delete(path)
    }
    
    class AuthService {
        +login(AuthRequest)
        +logout()
        +refreshToken(String)
    }
    
    class ApiResponse {
        +T? data
        +String? message
        +bool success
        +int? statusCode
    }
    
    class AuthInterceptor {
        +String? _token
        +updateToken(token)
        +onRequest(options)
    }
    
    class ErrorInterceptor {
        +onError(err, handler)
    }
    
    class LoggingInterceptor {
        +onRequest(options)
        +onResponse(response)
        +onError(err)
    }
    
    class AuthBloc {
        -AuthService _authService
        +_onLoginRequested(event)
        +_onLogoutRequested(event)
    }
    
    class InjectionContainer {
        -ApiClient _apiClient
        -AuthService _authService
        +init()
        +updateAuthToken(token)
    }
    
    ApiService <|-- AuthService
    ApiService --> ApiClient
    ApiClient --> AuthInterceptor
    ApiClient --> ErrorInterceptor
    ApiClient --> LoggingInterceptor
    AuthBloc --> AuthService
    InjectionContainer --> ApiClient
    InjectionContainer --> AuthService
    AuthService --> ApiResponse
```

## Поток данных при авторизации

```mermaid
sequenceDiagram
    participant User
    participant AuthPage
    participant AuthBloc
    participant AuthService
    participant ApiClient
    participant Interceptors
    participant API Server
    
    User->>AuthPage: Вводит логин/пароль
    AuthPage->>AuthBloc: AuthLoginRequested(login, password)
    AuthBloc->>AuthBloc: emit(AuthLoading)
    AuthBloc->>AuthService: login(AuthRequest)
    AuthService->>ApiClient: post('/auth/login', data)
    
    ApiClient->>Interceptors: Request проходит через цепочку
    Interceptors->>Interceptors: LoggingInterceptor: логирует запрос
    Interceptors->>Interceptors: AuthInterceptor: добавляет токен (если есть)
    Interceptors->>Interceptors: ErrorInterceptor: готов к обработке ошибок
    
    Interceptors->>API Server: HTTP POST /auth/login
    API Server-->>Interceptors: HTTP 200 + JSON Response
    
    Interceptors->>Interceptors: ErrorInterceptor: проверяет статус
    Interceptors->>Interceptors: LoggingInterceptor: логирует ответ
    
    Interceptors-->>ApiClient: Response
    ApiClient-->>AuthService: Response<T>
    AuthService->>AuthService: fromJson() -> AuthResponse
    AuthService-->>AuthBloc: ApiResponse<AuthResponse>
    
    alt Успешный ответ
        AuthBloc->>InjectionContainer: updateAuthToken(token)
        InjectionContainer->>AuthInterceptor: updateToken(token)
        AuthBloc->>AuthBloc: emit(AuthAuthenticated)
        AuthBloc-->>AuthPage: AuthAuthenticated state
        AuthPage->>User: Переход на главный экран
    else Ошибка
        AuthBloc->>AuthBloc: emit(AuthError)
        AuthBloc-->>AuthPage: AuthError state
        AuthPage->>User: Показывает ошибку
    end
```

## Структура файлов

```
lib/
├── core/
│   ├── network/
│   │   ├── api_client.dart          # HTTP клиент на Dio
│   │   ├── api_service.dart          # Базовый класс для сервисов
│   │   ├── api_response.dart         # Обертка для ответов
│   │   ├── api_exception.dart        # Класс исключений
│   │   ├── network.dart              # Экспорты
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart      # Добавление токена
│   │       ├── error_interceptor.dart     # Обработка ошибок
│   │       └── logging_interceptor.dart   # Логирование
│   ├── config/
│   │   └── api_config.dart           # Конфигурация API
│   └── di/
│       └── injection_container.dart  # DI контейнер
│
└── features/
    └── auth/
        ├── bloc/
        │   └── auth_bloc.dart        # Использует AuthService
        ├── services/
        │   └── auth_service.dart     # Наследует ApiService
        └── models/
            ├── auth_request.dart     # Модель запроса
            └── auth_response.dart    # Модель ответа
```

## Ключевые принципы

1. **Разделение ответственности**: UI → BLoC → Service → Network
2. **Единая точка входа**: `ApiService` для всех сервисов
3. **Автоматическая обработка**: Интерцепторы обрабатывают токены и ошибки
4. **Типобезопасность**: `ApiResponse<T>` с поддержкой дженериков
5. **Dependency Injection**: Централизованное управление зависимостями
6. **Расширяемость**: Легко добавить новые сервисы, наследуясь от `ApiService`
