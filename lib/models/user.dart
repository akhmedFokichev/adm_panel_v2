/// Модель пользователя
class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final DateTime createdAt;
  final bool isActive;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    required this.createdAt,
    this.isActive = true,
    this.role = 'user',
  });

  /// Создает тестовые данные
  factory User.mock({
    required String id,
    required String name,
    required String email,
    String? phone,
    bool? isActive,
    String? role,
  }) {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone ?? '+7 (999) 123-45-67',
      createdAt: DateTime.now().subtract(Duration(days: id.hashCode % 365)),
      isActive: isActive ?? true,
      role: role ?? 'user',
    );
  }

  /// Создает список тестовых пользователей
  static List<User> mockList() {
    return [
      User.mock(
        id: '1',
        name: 'Иван Иванов',
        email: 'ivan@example.com',
        phone: '+7 (999) 111-11-11',
        isActive: true,
        role: 'admin',
      ),
      User.mock(
        id: '2',
        name: 'Мария Петрова',
        email: 'maria@example.com',
        phone: '+7 (999) 222-22-22',
        isActive: true,
        role: 'user',
      ),
      User.mock(
        id: '3',
        name: 'Алексей Сидоров',
        email: 'alex@example.com',
        phone: '+7 (999) 333-33-33',
        isActive: false,
        role: 'user',
      ),
      User.mock(
        id: '4',
        name: 'Елена Козлова',
        email: 'elena@example.com',
        phone: '+7 (999) 444-44-44',
        isActive: true,
        role: 'moderator',
      ),
      User.mock(
        id: '5',
        name: 'Дмитрий Волков',
        email: 'dmitry@example.com',
        phone: '+7 (999) 555-55-55',
        isActive: true,
        role: 'user',
      ),
    ];
  }

  /// Создает список тестовых администраторов
  static List<User> mockAdministratorsList() {
    return [
      User.mock(
        id: 'adm-1',
        name: 'Александр Админов',
        email: 'admin@example.com',
        phone: '+7 (495) 111-11-11',
        isActive: true,
        role: 'super_admin',
      ),
      User.mock(
        id: 'adm-2',
        name: 'Иван Иванов',
        email: 'ivan.admin@example.com',
        phone: '+7 (495) 222-22-22',
        isActive: true,
        role: 'admin',
      ),
      User.mock(
        id: 'adm-3',
        name: 'Мария Админова',
        email: 'maria.admin@example.com',
        phone: '+7 (495) 333-33-33',
        isActive: true,
        role: 'admin',
      ),
      User.mock(
        id: 'adm-4',
        name: 'Петр Модераторов',
        email: 'petr.moderator@example.com',
        phone: '+7 (495) 444-44-44',
        isActive: true,
        role: 'moderator',
      ),
      User.mock(
        id: 'adm-5',
        name: 'Анна Системная',
        email: 'anna.admin@example.com',
        phone: '+7 (495) 555-55-55',
        isActive: false,
        role: 'admin',
      ),
    ];
  }
}
