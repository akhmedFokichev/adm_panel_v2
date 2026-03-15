/// Модель статистики для Dashboard
class DashboardStats {
  final int totalOrders;
  final int totalProducts;
  final int totalUsers;
  final double totalRevenue;
  final double revenueChange; // Процент изменения
  final double ordersChange; // Процент изменения
  final double productsChange; // Процент изменения
  final double usersChange; // Процент изменения

  DashboardStats({
    required this.totalOrders,
    required this.totalProducts,
    required this.totalUsers,
    required this.totalRevenue,
    required this.revenueChange,
    required this.ordersChange,
    required this.productsChange,
    required this.usersChange,
  });

  /// Создает тестовые данные
  factory DashboardStats.mock() {
    return DashboardStats(
      totalOrders: 1248,
      totalProducts: 342,
      totalUsers: 8567,
      totalRevenue: 245890.50,
      revenueChange: 12.5,
      ordersChange: 8.3,
      productsChange: -2.1,
      usersChange: 15.7,
    );
  }
}

/// Модель точки данных для графика
class ChartDataPoint {
  final String label;
  final double value;
  final DateTime? date;

  ChartDataPoint({
    required this.label,
    required this.value,
    this.date,
  });
}

/// Модель данных графика
class ChartData {
  final String title;
  final List<ChartDataPoint> dataPoints;
  final String? unit; // единица измерения (₽, шт, и т.д.)

  ChartData({
    required this.title,
    required this.dataPoints,
    this.unit,
  });

  /// Создает тестовые данные для графика продаж
  factory ChartData.mockSales() {
    return ChartData(
      title: 'Продажи за неделю',
      unit: '₽',
      dataPoints: [
        ChartDataPoint(label: 'Пн', value: 12000),
        ChartDataPoint(label: 'Вт', value: 19000),
        ChartDataPoint(label: 'Ср', value: 15000),
        ChartDataPoint(label: 'Чт', value: 22000),
        ChartDataPoint(label: 'Пт', value: 18000),
        ChartDataPoint(label: 'Сб', value: 25000),
        ChartDataPoint(label: 'Вс', value: 21000),
      ],
    );
  }

  /// Создает тестовые данные для графика заказов
  factory ChartData.mockOrders() {
    return ChartData(
      title: 'Заказы за неделю',
      unit: 'шт',
      dataPoints: [
        ChartDataPoint(label: 'Пн', value: 45),
        ChartDataPoint(label: 'Вт', value: 78),
        ChartDataPoint(label: 'Ср', value: 62),
        ChartDataPoint(label: 'Чт', value: 95),
        ChartDataPoint(label: 'Пт', value: 88),
        ChartDataPoint(label: 'Сб', value: 120),
        ChartDataPoint(label: 'Вс', value: 105),
      ],
    );
  }
}

