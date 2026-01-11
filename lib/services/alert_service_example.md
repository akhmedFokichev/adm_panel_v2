# Использование AlertService из ViewModel

## Регистрация сервиса

Сервис уже зарегистрирован в `lib/app/app.dart` через GetIt:

```dart
getIt.registerLazySingleton<AlertService>(
  () => AlertService()..initialize(navigatorKey: AppRouter.navigatorKey),
);
```

## Использование в ViewModel

### Пример 1: Простой вызов алерта

```dart
import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/services/alert_service.dart';
import 'package:stacked/stacked.dart';

class MyViewModel extends BaseViewModel {
  final _alertService = GetIt.instance<AlertService>();

  void someAction() {
    // Показать успешное сообщение
    _alertService.showSuccess(
      message: 'Операция выполнена успешно!',
    );
  }
}
```

### Пример 2: Обработка ошибок

```dart
class BasketViewmodel extends BaseViewModel {
  final _alertService = GetIt.instance<AlertService>();
  final _basketService = GetIt.instance<BasketService>();

  Future<void> tapBay(BasketShop basket) async {
    try {
      setBusy(true);
      
      // Выполняем операцию
      await _basketService.processOrder(basket);
      
      // Показываем успех
      _alertService.showSuccess(
        message: 'Заказ успешно оформлен!',
      );
    } catch (e) {
      // Показываем ошибку
      _alertService.showError(
        message: 'Не удалось оформить заказ: ${e.toString()}',
      );
    } finally {
      setBusy(false);
    }
  }
}
```

### Пример 3: Диалог подтверждения

```dart
class MyViewModel extends BaseViewModel {
  final _alertService = GetIt.instance<AlertService>();

  Future<void> deleteItem(String itemId) async {
    // Показываем диалог подтверждения
    final confirmed = await _alertService.showConfirm(
      title: 'Удалить элемент?',
      message: 'Вы уверены, что хотите удалить этот элемент?',
      confirmText: 'Удалить',
      cancelText: 'Отмена',
    );

    if (confirmed == true) {
      // Пользователь подтвердил удаление
      await _deleteItem(itemId);
      _alertService.showSuccessSnackBar(
        message: 'Элемент удален',
      );
    }
  }
}
```

### Пример 4: SnackBar с действием

```dart
class MyViewModel extends BaseViewModel {
  final _alertService = GetIt.instance<AlertService>();

  void addToCart(CartItem item) {
    _basketService.addItem(item, 1);
    
    // Показываем SnackBar с возможностью отменить
    _alertService.showSuccessSnackBar(
      message: 'Товар добавлен в корзину',
      actionLabel: 'Отменить',
      onAction: () {
        _basketService.removeItem(item, 1);
        _alertService.showInfoSnackBar(
          message: 'Действие отменено',
        );
      },
    );
  }
}
```

### Пример 5: Предупреждение перед действием

```dart
class MyViewModel extends BaseViewModel {
  final _alertService = GetIt.instance<AlertService>();

  Future<void> clearCart() async {
    final confirmed = await _alertService.showWarning(
      title: 'Очистить корзину?',
      message: 'Все товары будут удалены из корзины',
      confirmText: 'Очистить',
      cancelText: 'Отмена',
      onConfirm: () {
        _basketService.clearAll();
        _alertService.showSuccessSnackBar(
          message: 'Корзина очищена',
        );
      },
    );
  }
}
```

## Доступные методы AlertService

### Диалоги:
- `showSuccess()` - диалог успеха
- `showError()` - диалог ошибки
- `showWarning()` - диалог предупреждения
- `showInfo()` - информационный диалог
- `showConfirm()` - диалог подтверждения (возвращает Future<bool?>)

### SnackBar:
- `showSuccessSnackBar()` - успешное уведомление
- `showErrorSnackBar()` - уведомление об ошибке
- `showWarningSnackBar()` - предупреждение
- `showInfoSnackBar()` - информационное уведомление

## Преимущества

1. **Не нужен BuildContext** - сервис использует routerKey
2. **Единообразный стиль** - все алерты используют дизайн-систему
3. **Простое использование** - можно вызывать из любого места в коде
4. **Типобезопасность** - все методы типизированы



