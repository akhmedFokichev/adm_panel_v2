import 'category.dart';

/// Модель товара
class Product {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;
  final int quantityAvailable;
  final String categoryId; // ID категории
  final String? sku; // Артикул
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? attributes; // Дополнительные атрибуты

  Product({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.price,
    this.quantityAvailable = 0,
    required this.categoryId,
    this.sku,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
    this.attributes,
  });

  /// Создает тестовые данные товара
  factory Product.mock({
    required String id,
    required String name,
    String? description,
    String? imageUrl,
    required double price,
    int? quantityAvailable,
    required String categoryId,
    String? sku,
    bool? isActive,
    Map<String, dynamic>? attributes,
  }) {
    return Product(
      id: id,
      name: name,
      description: description ?? 'Описание товара $name',
      imageUrl: imageUrl,
      price: price,
      quantityAvailable: quantityAvailable ?? (id.hashCode % 100),
      categoryId: categoryId,
      sku: sku ?? 'SKU-${id.padLeft(6, '0')}',
      isActive: isActive ?? true,
      createdAt: DateTime.now().subtract(Duration(days: id.hashCode % 365)),
      updatedAt: DateTime.now().subtract(Duration(days: id.hashCode % 30)),
      attributes: attributes,
    );
  }

  /// Создает список тестовых товаров для категории
  static List<Product> mockListForCategory(String categoryId) {
    final products = <Product>[];
    
    // Генерируем товары в зависимости от категории
    final categoryProducts = {
      '1-1-1': ['iPhone 15 Pro', 'iPhone 14', 'iPhone 13'],
      '1-1-2': ['Galaxy S24', 'Galaxy S23', 'Galaxy A54'],
      '1-1-3': ['Xiaomi 14', 'Redmi Note 13', 'POCO X6'],
      '2-1-1': ['Футболка классическая', 'Футболка поло', 'Футболка с принтом'],
      '2-1-2': ['Джинсы классические', 'Джинсы скинни', 'Джинсы прямые'],
      '3-1': ['Кухонный стол', 'Стул кухонный', 'Шкаф кухонный'],
    };

    final names = categoryProducts[categoryId] ?? 
        ['Товар 1', 'Товар 2', 'Товар 3', 'Товар 4', 'Товар 5'];
    
    for (int i = 0; i < names.length; i++) {
      products.add(Product.mock(
        id: '$categoryId-$i',
        name: names[i],
        price: 1000.0 + (i * 500) + (categoryId.hashCode % 1000),
        categoryId: categoryId,
        quantityAvailable: 10 + (i * 5),
      ));
    }

    return products;
  }

  /// Создает список всех тестовых товаров
  static List<Product> mockAllProducts() {
    final allProducts = <Product>[];
    final categories = Category.mockCategories();
    
    void addProductsForCategory(Category category) {
      allProducts.addAll(mockListForCategory(category.id));
      for (final child in category.children) {
        addProductsForCategory(child);
      }
    }
    
    for (final category in categories) {
      addProductsForCategory(category);
    }
    
    return allProducts;
  }
}
