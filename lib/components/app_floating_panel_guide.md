# Руководство по использованию AppFloatingPanel

## Как положить новый экран в шторку

### Базовый пример

```dart
import 'package:adm_panel_v2/components/app_floating_panel.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();

    return Scaffold(
      appBar: AppBar(title: const Text('Мой экран')),
      body: AppFloatingPanelStack(
        controller: panelController,
        // 1. Фоновый контент (например, карта, изображение, или другой виджет)
        background: Container(
          color: Colors.blue.shade100,
          child: const Center(
            child: Text('Фоновый контент'),
          ),
        ),
        // 2. Ваш экран/виджет, который будет в шторке
        panel: YourCustomScreen(),
        // 3. Настройки размеров
        minHeight: 0.3,        // Минимальная высота (30% экрана)
        maxHeight: 0.8,        // Максимальная высота (80% экрана)
        initialHeight: 0.3,    // Начальная высота (30% экрана)
        snapPoints: [0.3, 0.5, 0.8], // Snap позиции
        showDragHandle: true,  // Показать драггер
        allowBackgroundInteraction: true, // Разрешить взаимодействие с фоном
      ),
    );
  }
}
```

## Важные моменты

### 1. Структура виджета

Ваш экран должен быть обычным виджетом (StatelessWidget или StatefulWidget):

```dart
class YourCustomScreen extends StatelessWidget {
  const YourCustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Заголовок (опционально)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Заголовок',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  // Закрыть панель через контроллер
                },
              ),
            ],
          ),
        ),
        const Divider(),
        // Контент вашего экрана
        Expanded(
          child: ListView(
            children: [
              // Ваши виджеты
            ],
          ),
        ),
      ],
    );
  }
}
```

### 2. Использование PanelController

Если нужно программно управлять панелью:

```dart
final panelController = PanelController();

// Открыть панель
panelController.open();

// Закрыть панель
panelController.close();

// Переместить к определенной позиции (в долях от 0.0 до 1.0)
panelController.animatePanelToPosition(0.5); // 50% экрана
```

### 3. Размеры (в долях от 0.0 до 1.0)

- `minHeight: 0.3` = 30% высоты экрана
- `maxHeight: 0.8` = 80% высоты экрана
- `initialHeight: 0.3` = Начальная высота 30%
- `snapPoints: [0.3, 0.5, 0.8]` = Фиксированные позиции: 30%, 50%, 80%

### 4. Параметры

| Параметр | Тип | Описание | По умолчанию |
|----------|-----|----------|--------------|
| `background` | `Widget` | Фоновый контент (обязательно) | - |
| `panel` | `Widget` | Контент шторки (обязательно) | - |
| `minHeight` | `double` | Минимальная высота (0.0-1.0) | `0.3` |
| `maxHeight` | `double` | Максимальная высота (0.0-1.0) | `0.8` |
| `initialHeight` | `double` | Начальная высота (0.0-1.0) | `0.3` |
| `snapPoints` | `List<double>?` | Snap-позиции (0.0-1.0) | `null` |
| `showDragHandle` | `bool` | Показать драггер | `true` |
| `controller` | `PanelController?` | Контроллер для управления | `null` |
| `allowBackgroundInteraction` | `bool` | Разрешить взаимодействие с фоном | `false` |
| `onPanelSlide` | `ValueChanged<double>?` | Callback при изменении позиции | `null` |

## Примеры использования

### Пример 1: Простой список

```dart
AppFloatingPanelStack(
  background: YourMapWidget(),
  panel: ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text('Элемент $index'),
      );
    },
  ),
)
```

### Пример 2: Полноценный экран с ViewModel

```dart
AppFloatingPanelStack(
  background: YourMapWidget(),
  panel: ViewModelBuilder<YourViewModel>.reactive(
    viewModelBuilder: () => YourViewModel(),
    builder: (context, model, child) {
      return YourScreenContent(model: model);
    },
  ),
)
```

### Пример 3: С программным управлением

```dart
class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  late final PanelController _panelController;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppFloatingPanelStack(
        controller: _panelController,
        background: YourBackgroundWidget(),
        panel: YourPanelContent(),
        minHeight: 0.3,
        maxHeight: 0.9,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Открыть панель программно
          _panelController.open();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Чек-лист для добавления экрана в шторку

1. ✅ Импортировать `app_floating_panel.dart`
2. ✅ Создать `PanelController` (если нужен)
3. ✅ Обернуть ваш экран в `AppFloatingPanelStack`
4. ✅ Указать `background` (фоновый контент)
5. ✅ Указать `panel` (ваш экран/виджет)
6. ✅ Настроить размеры (`minHeight`, `maxHeight`, `initialHeight`)
7. ✅ Опционально: добавить `snapPoints` для фиксированных позиций
8. ✅ Опционально: установить `allowBackgroundInteraction: true`

## Важно помнить

- **Ваш экран - это обычный виджет**, никаких специальных требований нет
- **Используйте `Expanded` или `Flexible`** для прокручиваемого контента
- **PanelController не требует dispose** - он управляется автоматически
- **Размеры указываются в долях** от 0.0 до 1.0 (не в пикселях)
- **Snap-позиции** - это фиксированные точки, где панель "защелкивается"

