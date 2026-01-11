import '../services/uuid_helper.dart';

/// Модель товара в корзине
class CartItem {
  final String id;
  final String shopId;
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;
  final int quantityAvailable;
  final int quantity;

  CartItem._({
    required this.id,
    required this.shopId,
    required this.name,
    this.description,
    this.imageUrl,
    required this.price,
    required this.quantityAvailable,
    required this.quantity,
  });

  factory CartItem({
    required String id,
    required String shopId,
    required String name,
    String? description,
    String? imageUrl,
    required double price,
    int quantity = 1,
    int quantityAvailable = 1000,
  }) {
    return CartItem._(
      id: id,
      shopId: shopId,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
      quantityAvailable: quantityAvailable,
      quantity: quantity,
    );
  }

  /// Создает копию товара с обновленным количеством
  CartItem copyWith({
    String? id,
    String? shopId,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    int? quantityAvailable,
    int? quantity,
  }) {
    return CartItem._(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantityAvailable: quantityAvailable ?? this.quantityAvailable,
      quantity: quantity ?? this.quantity,
    );
  }

  /// Общая стоимость товара (цена * количество)
  double get totalPrice => price * quantity;
}

extension CartItemExt on List<CartItem> {
  CartItem? findById(String id) {
    try {
      return firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }
}