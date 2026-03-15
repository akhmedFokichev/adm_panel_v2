# Admin Panel v2

Flutter проект с использованием BLoC архитектуры и MIX стилей.

## Архитектура

Проект использует **BLoC (Business Logic Component)** паттерн для управления состоянием приложения.

### Структура проекта

```
lib/
├── core/
│   └── bloc/
│       └── app_bloc_observer.dart    # Глобальный наблюдатель за BLoC событиями
├── design/
│   ├── app_colors.dart                # Цветовая палитра
│   └── mix_styles.dart                # Стили MIX
├── features/
│   └── counter/
│       ├── bloc/
│       │   ├── counter_bloc.dart      # BLoC логика
│       │   ├── counter_event.dart     # События
│       │   └── counter_state.dart     # Состояния
│       └── counter_page.dart          # UI страница
└── main.dart                          # Точка входа
```

## Зависимости

- **flutter_bloc**: ^8.1.6 - BLoC библиотека
- **bloc**: ^8.1.4 - Базовый BLoC пакет
- **equatable**: ^2.0.5 - Для сравнения объектов
- **mix**: ^1.7.0 - Система стилей

## Использование BLoC

### Создание BLoC

```dart
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    on<CounterIncremented>(_onIncremented);
  }
  
  void _onIncremented(CounterIncremented event, Emitter<CounterState> emit) {
    // Логика обработки события
  }
}
```

### Использование в UI

```dart
BlocProvider(
  create: (context) => CounterBloc(),
  child: BlocBuilder<CounterBloc, CounterState>(
    builder: (context, state) {
      // Построение UI на основе состояния
    },
  ),
)
```

## Использование MIX

### Определение стилей

```dart
static Style get primaryButton => Style(
  $box.padding(16, 24),
  $box.borderRadius(12),
  $box.color(AppColors.primary),
  $text.style.color(AppColors.textOnPrimary),
);
```

### Применение стилей

```dart
Box(
  style: MixStyles.primaryButton,
  child: StyledText(
    'Кнопка',
    style: MixStyles.primaryButton,
  ),
)
```

## Запуск проекта

1. Установите зависимости:
```bash
flutter pub get
```

2. Запустите приложение:
```bash
flutter run
```

## Примеры

Смотрите `lib/features/counter/` для примера использования BLoC + MIX.
