import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_drawer/custom_drawer.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';
import 'package:web_responsive_flutter/src/features/view_request/view_request_screen.dart';
import '../../app_configs/app_colors.dart';
import '../../common_widgets/custom_appbar/custom_appBar.dart';
import '../../utils/responsive.dart';

class ViewRequestScreen extends StatefulWidget {
  const ViewRequestScreen({super.key});

  @override
  State<ViewRequestScreen> createState() => _ViewRequestScreenState();
}

class _ViewRequestScreenState extends State<ViewRequestScreen> {
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
        title: "",
        actionImages: [
          AppImages.notification,
          AppImages.appBarProfile,
          AppImages.downArrow,
        ],
        imageUrl: AppImages.heroAppBar,
      ),
      backgroundColor: Colors.white,
      drawer: !isDesktop
          ? SizedBox(
              width: dashBoardProvider.isDrawerOpen ? 256 : 72,
              child: SideMenuWidget(
                menuItems: dashBoardProvider.menuItems,
                onItemSelected: (index) {
                  dashBoardProvider.handleMenuItemSelected(index, context);
                },
                isDrawerOpen: dashBoardProvider.isDrawerOpen,
                toggleDrawer: dashBoardProvider.toggleDrawer,
              ),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(""),
            )
          : null,
      body: Column(
        children: [
          const Divider(
            color: AppColors.lightGrey,
            thickness: 1,
            height: 1,
          ),
          Expanded(
            child: SafeArea(
              child: Row(
                children: [
                  if (isDesktop)
                    Expanded(
                      flex: 2,
                      child: SideMenuWidget(
                        menuItems: dashBoardProvider.menuItems,
                        onItemSelected: (index) {
                          dashBoardProvider.handleMenuItemSelected(
                              index, context);
                        },
                        isDrawerOpen: dashBoardProvider.isDrawerOpen,
                        toggleDrawer: dashBoardProvider.toggleDrawer,
                      ),
                    ),
                  const Expanded(
                    flex: 9,
                    child: ViewRequestPage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }
}
