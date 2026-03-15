/// Модель клиента (компании)
class Client {
  final String id;
  final String companyName;
  final String? inn; // ИНН
  final String? contactPerson; // Контактное лицо
  final String email;
  final String? phone;
  final String? address;
  final DateTime createdAt;
  final bool isActive;
  final String status; // vip, regular, new
  final int totalOrders; // Количество заказов

  Client({
    required this.id,
    required this.companyName,
    this.inn,
    this.contactPerson,
    required this.email,
    this.phone,
    this.address,
    required this.createdAt,
    this.isActive = true,
    this.status = 'regular',
    this.totalOrders = 0,
  });

  /// Создает тестовые данные
  factory Client.mock({
    required String id,
    required String companyName,
    String? inn,
    String? contactPerson,
    required String email,
    String? phone,
    String? address,
    bool? isActive,
    String? status,
    int? totalOrders,
  }) {
    return Client(
      id: id,
      companyName: companyName,
      inn: inn ?? '${7700000000 + id.hashCode % 1000000}',
      contactPerson: contactPerson ?? 'Иванов Иван Иванович',
      email: email,
      phone: phone ?? '+7 (999) 123-45-67',
      address: address ?? 'г. Москва, ул. Примерная, д. 1',
      createdAt: DateTime.now().subtract(Duration(days: id.hashCode % 365)),
      isActive: isActive ?? true,
      status: status ?? 'regular',
      totalOrders: totalOrders ?? (id.hashCode % 100),
    );
  }

  /// Создает список тестовых клиентов
  static List<Client> mockList() {
    return [
      Client.mock(
        id: '1',
        companyName: 'ООО "ТехноПром"',
        inn: '7701234567',
        contactPerson: 'Петров Петр Петрович',
        email: 'info@technoprom.ru',
        phone: '+7 (495) 111-11-11',
        address: 'г. Москва, ул. Ленина, д. 10',
        isActive: true,
        status: 'vip',
        totalOrders: 156,
      ),
      Client.mock(
        id: '2',
        companyName: 'ИП Сидоров А.А.',
        inn: '7707654321',
        contactPerson: 'Сидоров Алексей Алексеевич',
        email: 'sidorov@example.com',
        phone: '+7 (495) 222-22-22',
        address: 'г. Москва, пр. Мира, д. 25',
        isActive: true,
        status: 'regular',
        totalOrders: 42,
      ),
      Client.mock(
        id: '3',
        companyName: 'ООО "СтройМатериалы"',
        inn: '7709876543',
        contactPerson: 'Козлова Елена Викторовна',
        email: 'info@stroymat.ru',
        phone: '+7 (495) 333-33-33',
        address: 'г. Санкт-Петербург, Невский пр., д. 50',
        isActive: true,
        status: 'regular',
        totalOrders: 89,
      ),
      Client.mock(
        id: '4',
        companyName: 'ООО "Новая Компания"',
        inn: '7701111111',
        contactPerson: 'Волков Дмитрий Сергеевич',
        email: 'info@newcompany.ru',
        phone: '+7 (495) 444-44-44',
        address: 'г. Москва, ул. Новая, д. 5',
        isActive: false,
        status: 'new',
        totalOrders: 3,
      ),
      Client.mock(
        id: '5',
        companyName: 'ИП Иванова М.С.',
        inn: '7702222222',
        contactPerson: 'Иванова Мария Сергеевна',
        email: 'ivanova@example.com',
        phone: '+7 (495) 555-55-55',
        address: 'г. Казань, ул. Центральная, д. 15',
        isActive: true,
        status: 'vip',
        totalOrders: 234,
      ),
    ];
  }
}
