import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заказы'),
      ),
      body: const Center(
        child: Text(
          'Заказы',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
