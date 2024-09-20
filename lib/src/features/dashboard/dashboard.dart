import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_drawer/custom_drawer.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';
import 'package:web_responsive_flutter/src/features/dashboard/widget/dashboard_widget.dart';
import '../../app_configs/app_colors.dart';
import '../../common_widgets/custom_appbar/custom_appBar.dart';
import '../../utils/responsive.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
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
              const Expanded(
                flex: 9,
                child: DashboardWidget(),
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: dashBoardProvider.isDrawerOpen ? 256 : 40,
            child: GestureDetector(
              onTap: () {
                dashBoardProvider.toggleDrawer();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(4),
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
