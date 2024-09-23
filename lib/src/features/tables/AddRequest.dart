import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_appbar/custom_appBar.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_drawer/custom_drawer.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';
import 'package:web_responsive_flutter/src/features/tables/Inbound.dart';
import 'package:web_responsive_flutter/src/utils/responsive.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({super.key});

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AddRequestScreen(tabController: _tabController);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class AddRequestScreen extends StatelessWidget {
  const AddRequestScreen({super.key, required this.tabController});

  final TabController tabController;

  final List<String> _tabTitles = const [
    'Inbound Request',
    'Outbound Request',
    'In-plant Material Movement Request'
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final dashBoardProvider = context.watch<DashBoardController>();

    return
      Column(
        children: [
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: _tabTitles
                .map((title) => Tab(text: title))
                .toList(),
            labelStyle: const TextStyle(fontSize: 18),
            unselectedLabelStyle: const TextStyle(fontSize: 18),
            indicator: const UnderlineTabIndicator(
              borderSide:
              BorderSide(color: Colors.red, width: 4.0),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                Inbound(),
                Center(child: Text('Outbound Request content')),
                Center(
                    child: Text(
                        'In-plant Material Movement Request content')),
              ],
            ),
          ),
        ],
      );
  }
}
