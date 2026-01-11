
import 'package:adm_panel_v2/models/basket_shop.dart';

import '../models/cart_item.dart';

class BasketService {
  BasketShop? get cuurentBasket => _cuurentBasket;
  List<BasketShop> get baskets => _baskets;
  List<CartItem> get cartItems => _cartItems;

  BasketShop? _cuurentBasket;
  List<BasketShop> _baskets = [];
  List<CartItem> _cartItems = [];

  List<CartItem> cuurentBasketItems() {
    final shopId = cuurentBasket?.id ?? "";
    return _cartItems.where((u) => u.shopId == shopId).toList();
  }

  BasketShop? findShopWithID(String shopId) {
    final index = _baskets.indexWhere((e) => e.id == shopId);
    return index == -1 ? null : _baskets[index];
  }

  double totalPriceWithBasket(String shopId) {
    double result = 0.0;
    _cartItems.forEach((item) {
        if (item.shopId == shopId) {
          result = result + item.totalPrice;
        }
    });
    return result;
  }


  void selectShop(BasketShop basketShop) {
    _cuurentBasket = basketShop;
  }

  void addBasketShop(BasketShop basketShop, CartItem? item, int? count) {
    _addBasketShop(basketShop);
    if (item != null) {
      addItem(item!, count);
    }
  }

  void _addBasketShop(BasketShop basketShop) {
    final index = _baskets.indexWhere((e) => e.id == basketShop.id);
    if (index == -1){
      _baskets.add(basketShop);
    }

    // последниый магазин становиться выбранным
    _cuurentBasket = basketShop;
  }

  void addItem(CartItem item, int? count) {
    final index = _cartItems.indexWhere((e) => e.id == item.id);
    final _count = count ?? 1;

    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + _count,
      );
    } else {
      _cartItems.add(item.copyWith(quantity: _count));
    }
  }

  void removeItem(CartItem item, int count) {
    final index = _cartItems.indexWhere((e) => e.id == item.id);

    if (index != -1) {
      if (item.quantity > count) {
        _cartItems[index] = _cartItems[index].copyWith(
          quantity: _cartItems[index].quantity - count,
        );
      } else {
        _cartItems.removeAt(index);
      }
    }
  }

}