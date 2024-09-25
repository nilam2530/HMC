import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_appbar/custom_appBar.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_drawer/custom_drawer.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';

class ShellLayout extends StatelessWidget {
  final Widget child;

  const ShellLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final dashBoardProvider = context.watch<DashBoardController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = dashBoardProvider.isDrawerOpen ? 256.0 : 56.0;
    final availableWidth = screenWidth - drawerWidth;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Welcome to Inbound Logistics",
        actionImages: [
          AppImages.notification,
          AppImages.appBarProfile,
          AppImages.downArrow,
        ],
        imageUrl: AppImages.heroAppBar,
      ),
      backgroundColor: AppColors.backgroundColormain,
      body: Stack(
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: drawerWidth,
                child: SideMenuWidget(
                  menuItems: dashBoardProvider.menuItems,
                  onItemSelected: (index) {
                    dashBoardProvider.handleMenuItemSelected(index, context);
                  },
                  isDrawerOpen: dashBoardProvider.isDrawerOpen,
                  toggleDrawer: dashBoardProvider.toggleDrawer,
                ),
              ),
              // Expanded content to avoid overflow
              SizedBox(
                width: availableWidth,
                child: child,
              ),
            ],
          ),
          // Drawer toggle button
          Positioned(
            top: 16,
            left: drawerWidth,
            child: GestureDetector(
              onTap: dashBoardProvider.toggleDrawer,
              child: Container(
                width: 12,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.btnRedColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Icon(
                  dashBoardProvider.isDrawerOpen
                      ? Icons.arrow_back_ios
                      : Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
