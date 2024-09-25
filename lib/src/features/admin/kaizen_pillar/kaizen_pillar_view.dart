import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import '../../../app_configs/text_styles.dart';
import '../../../common_widgets/custom_data_table/custom_data_table.dart';
import '../../../models/kaizen_pillar_table_model.dart';
import 'provider/kaizen_pillar_controller.dart';

class KaizenPillarView extends StatefulWidget {
  const KaizenPillarView({super.key});

  @override
  State<KaizenPillarView> createState() => _KaizenPillarViewState();
}

class _KaizenPillarViewState extends State<KaizenPillarView> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<KaizenProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
        create: (context) => KaizenProvider(),
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kaizen Pillar',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darBlack),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'DashBoard | Kaizen Pillar',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.darBlack),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                            onTap: () {
                              GoRouter.of(context).go('/addPillar');
                            },
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: const BoxDecoration(
                                color: AppColors.darkMaron,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.zero,
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.circular(6),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Add Pillar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: AppColors.lightGrey),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "List Record",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AppColors.darBlack),
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Reset",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.25,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.dark3Grey,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                        color: AppColors.dark3Grey, width: 1),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.search, size: 20),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 14),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: "Search",
                                              border: InputBorder.none,
                                            ),
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 300),
                          child: CustomDataTableWidget<KaizenPillarTableModel>(
                            data: controller.newData,
                            columnTitles: const [
                              '  Id',
                              'Plant Name',
                              'Pillar Name',
                              'Pillar Head EC No',
                              'Sort Order',
                              'Status',
                            ],
                            columnTitlesStyle: textStyle(),
                            columnBuilders: [
                              (data) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data.id, style: textStyle()),
                                  ),
                              (data) =>
                                  Text(data.plantName, style: textStyle()),
                              (data) =>
                                  Text(data.pillarName, style: textStyle()),
                              (data) =>
                                  Text(data.pillarHeadECNo, style: textStyle()),
                              (data) => Text(data.sortNo, style: textStyle()),
                              (data) => Text(
                                    data.status,
                                    style: TextStyle(
                                      color: data.status == 'Pending'
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            ],
                            expandedContentBuilder: (data) => [
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(data.action, style: textStyle()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
