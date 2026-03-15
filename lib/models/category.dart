/// Модель категории товаров (многоуровневая структура)
class Category {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? parentId; // ID родительской категории (null для корневых)
  final int level; // Уровень вложенности (0 - корневой)
  final bool isActive;
  final List<Category> children; // Подкатегории
  final int productCount; // Количество товаров в категории

  Category({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.parentId,
    this.level = 0,
    this.isActive = true,
    List<Category>? children,
    this.productCount = 0,
  }) : children = children ?? [];

  /// Создает копию категории с обновленными полями
  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? parentId,
    int? level,
    bool? isActive,
    List<Category>? children,
    int? productCount,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      parentId: parentId ?? this.parentId,
      level: level ?? this.level,
      isActive: isActive ?? this.isActive,
      children: children ?? this.children,
      productCount: productCount ?? this.productCount,
    );
  }

  /// Получить полный путь категории (например: "Электроника > Смартфоны")
  String getFullPath(List<Category> allCategories) {
    if (parentId == null) return name;
    
    final parent = allCategories.firstWhere(
      (cat) => cat.id == parentId,
      orElse: () => Category(id: '', name: ''),
    );
    
    if (parent.id.isEmpty) return name;
    
    return '${parent.getFullPath(allCategories)} > $name';
  }

  /// Создает тестовые данные категорий
  static List<Category> mockCategories() {
    return [
      Category(
        id: '1',
        name: 'Электроника',
        description: 'Электронные устройства и гаджеты',
        level: 0,
        productCount: 45,
        children: [
          Category(
            id: '1-1',
            name: 'Смартфоны',
            parentId: '1',
            level: 1,
            productCount: 20,
            children: [
              Category(
                id: '1-1-1',
                name: 'Apple',
                parentId: '1-1',
                level: 2,
                productCount: 8,
              ),
              Category(
                id: '1-1-2',
                name: 'Samsung',
                parentId: '1-1',
                level: 2,
                productCount: 7,
              ),
              Category(
                id: '1-1-3',
                name: 'Xiaomi',
                parentId: '1-1',
                level: 2,
                productCount: 5,
              ),
            ],
          ),
          Category(
            id: '1-2',
            name: 'Ноутбуки',
            parentId: '1',
            level: 1,
            productCount: 15,
            children: [
              Category(
                id: '1-2-1',
                name: 'Игровые',
                parentId: '1-2',
                level: 2,
                productCount: 6,
              ),
              Category(
                id: '1-2-2',
                name: 'Офисные',
                parentId: '1-2',
                level: 2,
                productCount: 9,
              ),
            ],
          ),
          Category(
            id: '1-3',
            name: 'Планшеты',
            parentId: '1',
            level: 1,
            productCount: 10,
          ),
        ],
      ),
      Category(
        id: '2',
        name: 'Одежда',
        description: 'Мужская и женская одежда',
        level: 0,
        productCount: 120,
        children: [
          Category(
            id: '2-1',
            name: 'Мужская одежда',
            parentId: '2',
            level: 1,
            productCount: 60,
            children: [
              Category(
                id: '2-1-1',
                name: 'Футболки',
                parentId: '2-1',
                level: 2,
                productCount: 25,
              ),
              Category(
                id: '2-1-2',
                name: 'Джинсы',
                parentId: '2-1',
                level: 2,
                productCount: 20,
              ),
              Category(
                id: '2-1-3',
                name: 'Куртки',
                parentId: '2-1',
                level: 2,
                productCount: 15,
              ),
            ],
          ),
          Category(
            id: '2-2',
            name: 'Женская одежда',
            parentId: '2',
            level: 1,
            productCount: 60,
            children: [
              Category(
                id: '2-2-1',
                name: 'Платья',
                parentId: '2-2',
                level: 2,
                productCount: 30,
              ),
              Category(
                id: '2-2-2',
                name: 'Блузки',
                parentId: '2-2',
                level: 2,
                productCount: 20,
              ),
              Category(
                id: '2-2-3',
                name: 'Юбки',
                parentId: '2-2',
                level: 2,
                productCount: 10,
              ),
            ],
          ),
        ],
      ),
      Category(
        id: '3',
        name: 'Мебель',
        description: 'Мебель для дома и офиса',
        level: 0,
        productCount: 35,
        children: [
          Category(
            id: '3-1',
            name: 'Кухонная мебель',
            parentId: '3',
            level: 1,
            productCount: 15,
          ),
          Category(
            id: '3-2',
            name: 'Спальня',
            parentId: '3',
            level: 1,
            productCount: 12,
          ),
          Category(
            id: '3-3',
            name: 'Гостиная',
            parentId: '3',
            level: 1,
            productCount: 8,
          ),
        ],
      ),
    ];
  }
}
