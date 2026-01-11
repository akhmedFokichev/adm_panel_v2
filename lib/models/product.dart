
/// Модель товара в корзине
class Product {
  final String id;
  final String shopId;
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;
  final int quantityAvailable;

  Product(this.id, this.shopId, this.name, this.description, this.imageUrl, this.price, this.quantityAvailable);
  }