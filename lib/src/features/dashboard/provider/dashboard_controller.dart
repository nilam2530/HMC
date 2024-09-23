import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashBoardController with ChangeNotifier {
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;

  int get selectedIndex => _selectedIndex;
  bool get isDrawerOpen => _isDrawerOpen;

  final List<MenuItemData> menuItems = [
    const MenuItemData(title: "Dashboard", icon: Icons.dashboard),
    const MenuItemData(title: "Reports", icon: Icons.insert_chart),
    const MenuItemData(title: "Edit Request", icon: Icons.table_view_outlined),
    const MenuItemData(title: "View Request", icon: Icons.table_view_outlined),
    const MenuItemData(title: "Location", icon: Icons.table_view_outlined),
  ];
  final List<String> images = [
    'assets/images/carousel.png',
    'assets/images/carousel.png',
    'assets/images/carousel.png',
  ];
  final List<String> texts = [
    'A masterpiece for the\nmaster',
    'A masterpiece for the\nmaster',
    'A masterpiece for the\nmaster',
  ];
  final List<String> subTitle = [
    'Inspired by a vision a tribute to a legacy',
    'Inspired by a vision a tribute to a legacy',
    'Inspired by a vision a tribute to a legacy',
  ];
  final List<VoidCallback> buttonCallbacks = [
        () => print('Button 1 clicked'),
        () => print('Button 2 clicked'),
        () => print('Button 3 clicked'),
  ];

  void handleMenuItemSelected(int index, BuildContext context) {
    _selectedIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        GoRouter.of(context).go('/mainScreen');
        break;
      case 1:
        GoRouter.of(context).go('/requests');
        break;
      case 2:
        GoRouter.of(context).go('/editrequest');
        break;
      case 3:
        GoRouter.of(context).go('/viewrequest');
        break;
      case 4:
        GoRouter.of(context).go('/location');
        break;
      default:
        break;
    }
  }

  void toggleDrawer() {
    _isDrawerOpen = !_isDrawerOpen;
    notifyListeners();
  }
}

class MenuItemData {
  final String title;
  final IconData icon;

  const MenuItemData({
    required this.title,
    required this.icon,
  });
}
