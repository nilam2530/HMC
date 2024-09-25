// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class DashBoardController with ChangeNotifier {
//   int _selectedIndex = 0;
//   bool _isDrawerOpen = false;
//
//   int get selectedIndex => _selectedIndex;
//
//   bool get isDrawerOpen => _isDrawerOpen;
//
//   final List<MenuItemData> menuItems = [
//     const MenuItemData(title: "Dashboard", icon: Icons.dashboard),
//     const MenuItemData(title: "Reports", icon: Icons.insert_chart),
//     const MenuItemData(title: "Edit Request", icon: Icons.table_view_outlined),
//     const MenuItemData(title: "View Request", icon: Icons.table_view_outlined),
//     const MenuItemData(title: "Location", icon: Icons.table_view_outlined),
//     const MenuItemData(title: "Kiazen Panel", icon: Icons.table_view_outlined),
//     const MenuItemData(title: "Kaizen Theme", icon: Icons.dashboard),
//   ];
//
//   void handleMenuItemSelected(int index, BuildContext context) {
//     _selectedIndex = index;
//     notifyListeners();
//
//     switch (index) {
//       case 0:
//         GoRouter.of(context).go('/mainScreen');
//         break;
//       case 1:
//         GoRouter.of(context).go('/requests');
//         break;
//       case 2:
//         GoRouter.of(context).go('/editrequest');
//         break;
//       case 3:
//         GoRouter.of(context).go('/viewrequest');
//         break;
//       case 4:
//         GoRouter.of(context).go('/location');
//         break;
//       case 5:
//         GoRouter.of(context).go('/shivendra');
//       default:
//         break;
//     }
//   }
//
//   void toggleDrawer() {
//     _isDrawerOpen = !_isDrawerOpen;
//     notifyListeners();
//   }
// }
//
// class MenuItemData {
//   final String title;
//   final IconData icon;
//
//   const MenuItemData({
//     required this.title,
//     required this.icon,
//   });
// }
