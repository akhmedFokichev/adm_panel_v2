import 'package:get_it/get_it.dart';
import 'package:adm_panel_v2/models/basket_shop.dart';
import 'package:adm_panel_v2/services/alert_service.dart';
import 'package:adm_panel_v2/services/basket_service.dart';
import 'package:stacked/stacked.dart';

import '../../components/app_scrollable_labels.dart';
import '../../models/cart_item.dart';

class BasketViewmodel extends BaseViewModel {
  List<CartItem> get cartItems => basketService.cuurentBasketItems();
  BasketShop? get cuurentBasket => basketService.cuurentBasket;

  final basketService = GetIt.instance<BasketService>();
  final alertService = GetIt.instance<AlertService>();

  final Set<String> _selectedLabelIds = {};
  Set<String> get selectedLabelIds => _selectedLabelIds;

  List<ScrollableLabel> get labels {
    return basketService.baskets.map((shop) {
      return ScrollableLabel(
        id: shop.id,
        label: shop.name,
      );
    }).toList();
  }

  void toggleLabelSelection(String id) {
    if (_selectedLabelIds.contains(id)) {
      return;
    }

    _selectedLabelIds.clear();
    _selectedLabelIds.add(id);

    final basketShop = basketService.findShopWithID(id);
    if (basketShop != null) {
      basketService.selectShop(basketShop);
      notifyListeners();
    }
  }

  void addCartItem(CartItem item) {
    basketService.addItem(item, 1);
    notifyListeners();

    // Показываем уведомление о добавлении
    alertService.showSuccessSnackBar(
      message: '${item.name} добавлен в корзину',
      actionLabel: 'Отменить',
      onAction: () {
        removeCartItem(item);
        alertService.showInfoSnackBar(
          message: 'Товар удален из корзины',
        );
      },
    );
  }

  void removeCartItem(CartItem item) {
    basketService.removeItem(item, 1);
    notifyListeners();
  }

  Future<void> tapBay(BasketShop basket) async {
    // Пример использования AlertService из viewmodel
    final confirmed = await alertService.showConfirm(
      title: 'Оформить заказ?',
      message: 'Вы хотите оформить заказ в магазине "${basket.name}"?',
      confirmText: 'Оформить',
      cancelText: 'Отмена',
    );

    if (confirmed == true) {
      // Пользователь подтвердил заказ
      try {
        // Здесь была бы логика оформления заказа
        // await orderService.createOrder(basket);

        alertService.showSuccess(
          message: 'Заказ успешно оформлен!',
        );
      } catch (e) {
        alertService.showError(
          message: 'Не удалось оформить заказ. Попробуйте позже.',
        );
      }
    }
  }

  double totalPriceWithBasket(String shopId) {
    return basketService.totalPriceWithBasket(shopId);
  }

  initialize() {
    _buildMOKData();
    notifyListeners();

    print("initialize>cuurentBasket>" +
        basketService.cuurentBasket!.id.toString());
    print(
        "initialize>baskets.length>" + basketService.baskets.length.toString());
    print("initialize>cartItems.length>" +
        basketService.cartItems.length.toString());
    print("basketService.cuurentBasketItems().length>" +
        basketService.cuurentBasketItems().length.toString());
    print("basketService.cuurentBasketItems().isEmpty>" +
        basketService.cuurentBasketItems().isEmpty.toString());
  }

  // создаем мок данные
  _buildMOKData() {
    final List<BasketShop> baskets = [
      BasketShop(id: "shopId222", name: "Local"),
      BasketShop(id: "shopId333", name: "tameris"),
      BasketShop(id: "shopId555", name: "top33"),
      BasketShop(id: "shopId444", name: "globus"),
      BasketShop(id: "shopId777", name: "toffik"),
      BasketShop(id: "shopId111", name: "KFS"),
    ];

    final List<CartItem> items = [
      CartItem(id: "12ddd", shopId: "shopId111", name: "pazza", price: 50.4),
      CartItem(
          id: "12111dddd", shopId: "shopId111", name: "cola", price: 100.43),
      CartItem(id: "12166dddd", shopId: "shopId222", name: "coffee", price: 34),
      CartItem(id: "12144dddd", shopId: "shopId222", name: "tea", price: 55.43),
      CartItem(
          id: "12144dddd",
          shopId: "shopId333",
          name: "cola zero",
          price: 530.4),
      CartItem(
          id: "1216644dddd", shopId: "shopId333", name: "coffee11", price: 34),
      CartItem(
          id: "121488884dddd",
          shopId: "shopId333",
          name: "te111a",
          price: 55.43),
      CartItem(
          id: "12166ffffdddd",
          shopId: "shopId222",
          name: "coffee444",
          price: 34),
      CartItem(
          id: "1214466dddd", shopId: "shopId222", name: "tea555", price: 55.43),
      CartItem(
          id: "121yhh66dddd", shopId: "shopId222", name: "coffee44", price: 34),
      CartItem(
          id: "12144hhghghgdddd",
          shopId: "shopId222",
          name: "tea66",
          price: 55.43),
    ];

    baskets.forEach((basket) {
      basketService.addBasketShop(basket, null, null);
    });

    items.forEach((item) {
      basketService.addItem(item, 1);
    });
  }
}
