import 'package:flutter/material.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_images.dart';
import 'package:adm_panel_v2/features/main/tabs/home_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/orders_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/cart_tab.dart';
import 'package:adm_panel_v2/features/main/tabs/profile_tab.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  bool _isSwipeEnabled = true; // По умолчанию прокрутка включена

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleSwipe() {
    setState(() {
      _isSwipeEnabled = !_isSwipeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: _isSwipeEnabled
            ? const ClampingScrollPhysics() // Прокрутка включена
            : const NeverScrollableScrollPhysics(), // Прокрутка выключена
        children: const [
          HomeTab(),
          OrdersTab(),
          CartTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Кнопка переключения прокрутки (опционально, можно убрать)
            GestureDetector(
              onLongPress: _toggleSwipe,
              child: Container(
                height: 2,
                color: _isSwipeEnabled
                    ? AppColors.primary.withOpacity(0.3)
                    : Colors.transparent,
              ),
            ),
            BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                _tabController.animateTo(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 24,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.home),
                  activeIcon: Icon(AppIcons.homeFilled),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.orders),
                  activeIcon: Icon(AppIcons.ordersFilled),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.cart),
                  activeIcon: Icon(AppIcons.cartFilled),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.profile),
                  activeIcon: Icon(AppIcons.profileFilled),
                  label: '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
