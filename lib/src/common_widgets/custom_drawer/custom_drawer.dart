import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/features/sidebar/controller/sidemenu_controller.dart';
import 'package:web_responsive_flutter/src/themes/theme_provider.dart';

class SideMenuWidget extends StatelessWidget {
  final List<MenuItemData> menuItems;
  final Function(int) onItemSelected;
  final bool isDrawerOpen;
  final VoidCallback toggleDrawer;

  const SideMenuWidget({
    super.key,
    required this.menuItems,
    required this.onItemSelected,
    required this.isDrawerOpen,
    required this.toggleDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, model, child) {
        return AnimatedContainer(
          width: isDrawerOpen ? 256 : 72,
          // Animate width change
          duration: const Duration(milliseconds: 200),
          height: 1089,
          // Fixed height as per your requirement
          decoration:  BoxDecoration(
            color: model.currentThemeMode== ThemeMode.dark?Colors.white:Colors.black,
            border: const Border(
              right: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          child: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final menuItem = menuItems[index];
              return MenuEntry(
                icon: menuItem.icon,
                title: menuItem.title,
                isSelected: false,
                isDrawerOpen: isDrawerOpen,
                // Pass isDrawerOpen down
                onTap: () => onItemSelected(index),
              );
            },
          ),
        );
      }
    );
  }
}

// Define MenuEntry Widget
class MenuEntry extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final bool isDrawerOpen;
  final VoidCallback onTap;

  const MenuEntry({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.isDrawerOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
            if (isDrawerOpen)
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
