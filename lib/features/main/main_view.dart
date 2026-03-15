import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/features/main/tabs/home_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/orders_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/users_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/clients_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/products_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/administrators_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/design_system_tab.dart';
import 'package:adm_panel_v2/features/main/layout/main_sidebar.dart';
import 'package:adm_panel_v2/features/main/layout/main_top_bar.dart';
import 'package:adm_panel_v2/features/main/layout/main_bottom_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    OrdersTab(),
    UsersTab(),
    ClientsTab(),
    ProductsTab(),
    AdministratorsTab(),
    DesignSystemTab(),
  ];

  final List<String> _titles = const [
    'Главная',
    'Заказы',
    'Пользователи',
    'Клиенты',
    'Товары',
    'Администраторы',
    'Дизайн-система',
  ];

  void _onItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Боковой фиксированный view (160px)
          MainSidebar(
            currentIndex: _currentIndex,
            onItemSelected: _onItemSelected,
          ),
          // Основной контент
          Expanded(
            child: Column(
              children: [
                // Верхний view (56px)
                MainTopBar(
                  title: _titles[_currentIndex],
                ),
                // Контент (занимает оставшееся пространство)
                Expanded(
                  child: Container(
                    color: AppColors.background,
                    child: _tabs[_currentIndex],
                  ),
                ),
                // Нижний view (40px)
                MainBottomBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
