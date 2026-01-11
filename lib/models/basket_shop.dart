
import '../services/uuid_helper.dart';
import 'cart_item.dart';

/// Модель товара в корзине
class BasketShop {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;

  BasketShop._({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
  });

  factory BasketShop({
    required String id,
    required String name,
    String? description,
    String? imageUrl,
  }) {
    return BasketShop._(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
    );
  }
}