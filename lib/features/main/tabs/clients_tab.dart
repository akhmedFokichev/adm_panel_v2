import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/models/client.dart';
import 'package:adm_panel_v2/components/app_card.dart';

class ClientsTab extends StatefulWidget {
  const ClientsTab({super.key});

  @override
  State<ClientsTab> createState() => _ClientsTabState();
}

class _ClientsTabState extends State<ClientsTab> {
  List<Client> _clients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    setState(() {
      _isLoading = true;
    });

    // Имитация загрузки данных
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _clients = Client.mockList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок и действия
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Клиенты',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Добавить создание клиента
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Добавить клиента'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Таблица клиентов
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : AppCard(
                    padding: EdgeInsets.zero,
                    child: _ClientsTable(clients: _clients),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ClientsTable extends StatelessWidget {
  final List<Client> clients;

  const _ClientsTable({required this.clients});

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
            label: Text('Название компании'),
          ),
          DataColumn(
            label: Text('ИНН'),
          ),
          DataColumn(
            label: Text('Контактное лицо'),
          ),
          DataColumn(
            label: Text('Email'),
          ),
          DataColumn(
            label: Text('Телефон'),
          ),
          DataColumn(
            label: Text('Адрес'),
          ),
          DataColumn(
            label: Text('Статус'),
          ),
          DataColumn(
            label: Text('Заказов'),
          ),
          DataColumn(
            label: Text('Дата регистрации'),
          ),
          DataColumn(
            label: Text('Действия'),
          ),
        ],
        rows: clients.map((client) {
          return DataRow(
            cells: [
              DataCell(Text(client.id)),
              DataCell(
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.business,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      client.companyName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(Text(client.inn ?? '-')),
              DataCell(Text(client.contactPerson ?? '-')),
              DataCell(Text(client.email)),
              DataCell(Text(client.phone ?? '-')),
              DataCell(
                SizedBox(
                  width: 200,
                  child: Text(
                    client.address ?? '-',
                    style: AppTextStyles.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(client.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getStatusLabel(client.status),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: _getStatusColor(client.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataCell(
                Text(
                  client.totalOrders.toString(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  '${client.createdAt.day}.${client.createdAt.month}.${client.createdAt.year}',
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
                        // TODO: Редактирование клиента
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      color: AppColors.error,
                      onPressed: () {
                        // TODO: Удаление клиента
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'vip':
        return AppColors.warning;
      case 'new':
        return AppColors.info;
      default:
        return AppColors.success;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'vip':
        return 'VIP';
      case 'new':
        return 'Новый';
      default:
        return 'Обычный';
    }
  }
}
