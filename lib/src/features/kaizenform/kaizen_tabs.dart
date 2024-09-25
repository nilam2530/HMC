import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/features/kaizenform/kaizen_form.dart';

class KaizensTabs extends StatefulWidget {
  const KaizensTabs({super.key});

  @override
  State<KaizensTabs> createState() => _KaizensTabsState();
}

class _KaizensTabsState extends State<KaizensTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    'ADD KAIZEN',
    'PREVIEW',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: _tabTitles.map((title) {
            return Padding(
              padding: const EdgeInsets.only(left: 5,right: 5), // Padding of 10 on all sides
              child: Tab(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 12), // Text size 12
                ),
              ),
            );
          }).toList(),
          labelStyle: const TextStyle(fontSize: 18),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          labelColor: Colors.white, // Selected tab text color
          unselectedLabelColor: Colors.grey, // Unselected tab text color
          indicator: const BoxDecoration(
            color: Colors.red, // Selected tab background color
            border: Border(
              bottom: BorderSide(color: Colors.red, width: 4.0), // Red underline
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              KaizenForm(),
              const Center(child: Text('Outbound Request content')),
              const Center(child: Text('In-plant Material Movement Request content')),
            ],
          ),
        ),
      ],
    );
  }
}
