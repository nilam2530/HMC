import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/features/tables/InboundDesktop.dart';
import 'package:web_responsive_flutter/src/features/tables/InboundMobile.dart';

class EditRequestScreen extends StatefulWidget {
  const EditRequestScreen({super.key});

  @override
  State<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends State<EditRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return const InboundDesktop();
          } else {
            return const InboundMobile();
          }
        },
      ),
    );
  }
}

// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = Responsive.isDesktop(context);
//     final dashBoardProvider = context.watch<DashBoardController>();
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "",
//         actionImages: [
//           AppImages.notification,
//           AppImages.appBarProfile,
//           AppImages.downArrow
//         ],
//         imageUrl: AppImages.heroAppBar,
//       ),
//       backgroundColor: Colors.white,
//       drawer: !isDesktop
//           ? SizedBox(
//               width: 250,
//               child: SideMenuWidget(
//                 menuItems: dashBoardProvider.menuItems,
//                 onItemSelected: (index) {
//                   dashBoardProvider.handleMenuItemSelected(index, context);
//                 },
//                 isDrawerOpen: dashBoardProvider.isDrawerOpen,
//                 toggleDrawer: dashBoardProvider.toggleDrawer,
//               ),
//             )
//           : null,
//       endDrawer: Responsive.isMobile(context)
//           ? SizedBox(
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: const Text(""),
//             )
//           : null,
//       body: Column(
//         children: [
//           const Divider(
//             color: AppColors.lightGrey,
//             thickness: 1,
//             height: 1,
//           ),
//           Expanded(
//             child: SafeArea(
//               child: Row(
//                 children: [
//                   if (isDesktop)
//                     Expanded(
//                       flex: 2,
//                       child: SideMenuWidget(
//                         menuItems: dashBoardProvider.menuItems,
//                         onItemSelected: (index) {
//                           dashBoardProvider.handleMenuItemSelected(
//                               index, context);
//                         },
//                         isDrawerOpen: dashBoardProvider.isDrawerOpen,
//                         toggleDrawer: dashBoardProvider.toggleDrawer,
//                       ),
//                     ),
//                   Expanded(
//                     flex: 9,
//                     child: ,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
