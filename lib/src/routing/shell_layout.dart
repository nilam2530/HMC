import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_appbar/custom_appBar.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_drawer/custom_drawer.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';

class ShellLayout extends StatelessWidget {
  final Widget child;

  const ShellLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashBoardProvider = context.watch<DashBoardController>();

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Row(
            children: [
              // Side menu widget with animated drawer open/close feature
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: dashBoardProvider.isDrawerOpen ? 256 : 56,
                child: SideMenuWidget(
                  menuItems: dashBoardProvider.menuItems,
                  onItemSelected: (index) {
                    dashBoardProvider.handleMenuItemSelected(index, context);
                  },
                  isDrawerOpen: dashBoardProvider.isDrawerOpen,
                  toggleDrawer: dashBoardProvider.toggleDrawer,
                ),
              ),
              // Expanded area to hold the child content or dashboard content
              Expanded(
                flex: 9,
                child: child,
              ),
            ],
          ),
          // Positioned widget for the toggle drawer button
          Positioned(
            top: 16,
            left: dashBoardProvider.isDrawerOpen ? 256 : 56,
            child: GestureDetector(
              onTap: () {
                dashBoardProvider.toggleDrawer();
              },
              child: Container(
                width: 12,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.btnRedColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
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
