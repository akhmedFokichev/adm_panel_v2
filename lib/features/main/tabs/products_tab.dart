import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/models/product.dart';
import 'package:adm_panel_v2/models/category.dart';
import 'package:adm_panel_v2/components/app_card.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  List<Category> _categories = [];
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  String? _selectedCategoryId;
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    // Имитация загрузки данных
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _categories = Category.mockCategories();
      _allProducts = Product.mockAllProducts();
      _filteredProducts = _allProducts;
      _isLoading = false;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _selectedCategoryId == null
            ? _allProducts
            : _allProducts.where((p) => p.categoryId == _selectedCategoryId).toList();
      } else {
        _filteredProducts = _allProducts.where((product) {
          final matchesSearch = product.name.toLowerCase().contains(query) ||
              (product.description?.toLowerCase().contains(query) ?? false) ||
              (product.sku?.toLowerCase().contains(query) ?? false);
          final matchesCategory = _selectedCategoryId == null ||
              product.categoryId == _selectedCategoryId;
          return matchesSearch && matchesCategory;
        }).toList();
      }
    });
  }

  void _selectCategory(String? categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      if (categoryId == null) {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts = _allProducts.where((p) => p.categoryId == categoryId).toList();
      }
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Боковая панель с категориями
          _CategoryTree(
            categories: _categories,
            selectedCategoryId: _selectedCategoryId,
            onCategorySelected: _selectCategory,
          ),
          const SizedBox(width: 16),
          // Основная область с товарами
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок и действия
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCategoryId == null
                          ? 'Все товары'
                          : _getCategoryName(_selectedCategoryId!),
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Поиск товаров...',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _searchController.clear();
                                      },
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Добавить создание товара
                          },
                          icon: const Icon(Icons.add, size: 20),
                          label: const Text('Добавить товар'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Таблица товаров
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _filteredProducts.isEmpty
                          ? Center(
                              child: Text(
                                'Товары не найдены',
                                style: AppTextStyles.bodyLarge.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            )
                          : AppCard(
                              padding: EdgeInsets.zero,
                              child: _ProductsTable(products: _filteredProducts),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    Category? findCategory(List<Category> categories) {
      for (final category in categories) {
        if (category.id == categoryId) return category;
        final found = findCategory(category.children);
        if (found != null) return found;
      }
      return null;
    }

    return findCategory(_categories)?.name ?? 'Неизвестная категория';
  }
}

class _CategoryTree extends StatelessWidget {
  final List<Category> categories;
  final String? selectedCategoryId;
  final Function(String?) onCategorySelected;

  const _CategoryTree({
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Категории',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => onCategorySelected(null),
                  child: const Text('Все'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                ...categories.map((category) => _CategoryItem(
                      category: category,
                      selectedCategoryId: selectedCategoryId,
                      onCategorySelected: onCategorySelected,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatefulWidget {
  final Category category;
  final String? selectedCategoryId;
  final Function(String?) onCategorySelected;

  const _CategoryItem({
    required this.category,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  State<_CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<_CategoryItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.selectedCategoryId == widget.category.id;
    final hasChildren = widget.category.children.isNotEmpty;

    return Column(
      children: [
        InkWell(
          onTap: () => widget.onCategorySelected(widget.category.id),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.only(
              left: 16.0 + (widget.category.level * 16),
              right: 16,
              top: 12,
              bottom: 12,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                if (hasChildren)
                  IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  )
                else
                  const SizedBox(width: 28),
                Expanded(
                  child: Text(
                    widget.category.name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.category.productCount.toString(),
                    style: AppTextStyles.labelSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded && hasChildren)
          ...widget.category.children.map((child) => _CategoryItem(
                category: child,
                selectedCategoryId: widget.selectedCategoryId,
                onCategorySelected: widget.onCategorySelected,
              )),
      ],
    );
  }
}

class _ProductsTable extends StatelessWidget {
  final List<Product> products;

  const _ProductsTable({required this.products});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(AppColors.surfaceVariant),
        columns: const [
          DataColumn(
            label: Text('ID'),
          ),
          DataColumn(
            label: Text('Название'),
          ),
          DataColumn(
            label: Text('Артикул'),
          ),
          DataColumn(
            label: Text('Категория'),
          ),
          DataColumn(
            label: Text('Цена'),
          ),
          DataColumn(
            label: Text('Остаток'),
          ),
          DataColumn(
            label: Text('Статус'),
          ),
          DataColumn(
            label: Text('Дата создания'),
          ),
          DataColumn(
            label: Text('Действия'),
          ),
        ],
        rows: products.map((product) {
          return DataRow(
            cells: [
              DataCell(Text(product.id)),
              DataCell(
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: product.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image, size: 20),
                              ),
                            )
                          : const Icon(Icons.image, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product.name,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (product.description != null)
                            Text(
                              product.description!,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(Text(product.sku ?? '-')),
              DataCell(Text(product.categoryId)),
              DataCell(
                Text(
                  '${product.price.toStringAsFixed(2)} ₽',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  product.quantityAvailable.toString(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: product.quantityAvailable > 0
                        ? AppColors.success
                        : AppColors.error,
                  ),
                ),
              ),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: product.isActive
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: product.isActive
                              ? AppColors.success
                              : AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        product.isActive ? 'Активен' : 'Неактивен',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: product.isActive
                              ? AppColors.success
                              : AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DataCell(
                Text(
                  '${product.createdAt.day}.${product.createdAt.month}.${product.createdAt.year}',
                  style: AppTextStyles.bodySmall,
                ),
              ),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      color: AppColors.primary,
                      onPressed: () {
                        // TODO: Редактирование товара
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      color: AppColors.error,
                      onPressed: () {
                        // TODO: Удаление товара
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
