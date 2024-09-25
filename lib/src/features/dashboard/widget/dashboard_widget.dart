import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/features/filter/filter_screen.dart';
import '../../../common_widgets/data_table.dart';
import '../../../common_widgets/summary_card.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;
  bool isExpanded = false;
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final GlobalKey _buttonKey = GlobalKey();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this)
      ..addListener(() {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _tabController.dispose();

    super.dispose();
  }

  Color _getLabelColor(int index) {
    return _selectedTabIndex == index
        ? AppColors.darkMaron
        : AppColors.dark4Grey;
  }

  Color _getIndicatorColor() {
    return AppColors.darkMaron; // Change this to your desired indicator color
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColormain,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildHeader(context),
                      SizedBox(height: isMobile ? 8 : 8),
                      _buildSummaryCards(isMobile),
                      Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 0, bottom: 0),
                            height: 1100,
                            //width: 722,
                            decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(
                                  color: AppColors.dark2Grey,
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                _buildSearchAndActions(isMobile),
                                const SizedBox(height: 10),
                                _buildRequestTabs(isMobile),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: const [
                                      DataTableWidget(),
                                      // All Requests
                                      Center(child: Text("Inbound Requests")),
                                      // Inbound
                                      Center(child: Text("Outbound Requests")),
                                      // Outbound
                                      Center(
                                          child:
                                          Text("In-plant Material Movement")),
                                      // In-plant
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showAttachedDialog(BuildContext context) {
    final RenderBox buttonBox =
    _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);
    final buttonSize = buttonBox.size;
    const double dialogWidth = 340;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Stack(
          children: [
            Positioned(
              left: buttonPosition.dx - buttonSize.width - 250,
              top: buttonPosition.dy - 50,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16.0),
                child: const SizedBox(
                  width: dialogWidth,
                  height: 400,
                  child: FilterDialogContent(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Row _buildHeader(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Dashboard",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.darBlack,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await _pickDate(context);
            if (_selectedDate != null) {
              await _pickTime(
                  context); // Open time picker after date is selected
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              color: AppColors.greyBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                Text(
                  '${DateFormat('MMM yyyy').format(_selectedDate ?? DateTime.now())} at ${_selectedTime != null ? _selectedTime!.format(context) : TimeOfDay.now().format(context)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darBlack,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.keyboard_arrow_down_outlined, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(bool isMobile) {
    return Row(
      mainAxisAlignment:
      isMobile ? MainAxisAlignment.start : MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: SummaryCard(
            bgImg: Image.asset(AppImages.bgImgCard1),
            iconBackgroundColor: AppColors.bgPenDing,
            imagePath: AppImages.summaryVector,
            value: '40',
            label: 'Pending Requests',
            backgroundColor: AppColors.penDingColors,
          ),
        ),
        Expanded(
          child: SummaryCard(
            bgImg: Image.asset(AppImages.bgImgCard2),
            imagePath: AppImages.summaryVector,
            value: '25',
            label: 'Completed Requests',
            backgroundColor: AppColors.approvalColors,
            imageSize: 20.0,
            iconBackgroundColor: AppColors.bgApproval,
          ),
        ),
        if (!isMobile)
          Expanded(
            child: SummaryCard(
              bgImg: Image.asset(AppImages.bgImgCard),
              imagePath: AppImages.summaryVector,
              value: '33',
              label: 'Completed Requests',
              backgroundColor: AppColors.rejectColors,
              imageSize: 20.0,
              iconBackgroundColor: AppColors.bgReject,
            ),
          ),
        Expanded(
          child: SummaryCard(
            bgImg: Image.asset(AppImages.bgImgCard),
            imagePath: AppImages.summaryVector,
            value: '435',
            label: 'Completed Requests',
            backgroundColor: AppColors.completionColors,
            imageSize: 20.0,
            iconBackgroundColor: AppColors.bgComplete,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndActions(bool isMobile) {
    return Row(
      children: [
        Expanded(
            child: Container(
              width: 150,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: AppColors.dark3Grey,
                border: Border.all(
                  color: AppColors.dark3Grey,
                  width: 1.0,
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.search, size: 20),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 1),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search by request no",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        if (!isMobile) const Spacer(),
        const SizedBox(width: 16),
        InkWell(
          key: _buttonKey,
          onTap: () {
            showAttachedDialog(context);
          },
          child: Container(
            height: 35,
            width: 85,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.darkMaron, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(AppImages.filter, height: 16, width: 16),
                const Text(
                  "Filter",
                  style: TextStyle(fontSize: 14, color: AppColors.darkMaron),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        _buildAddRequestButton(),
      ],
    );
  }

  Widget _buildAddRequestButton() {
    return Container(
      height: 35,
      width: 150,
      decoration: const BoxDecoration(
          color: AppColors.darkMaron,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(AppImages.addNew, width: 16, height: 16),
            const Text(
              "Add Request",
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestTabs(bool isMobile) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      indicatorWeight: 0.1,
      indicatorPadding: EdgeInsets.zero,
      indicatorSize: TabBarIndicatorSize.label,
      controller: _tabController,
      isScrollable: !isMobile,
      labelColor: AppColors.darkMaron,
      indicatorColor: _getIndicatorColor(),
      tabs: [
        Tab(
          child: Text(
            "All Requests",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _getLabelColor(0)),
          ),
        ),
        Tab(
          child: Text(
            "Inbound",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _getLabelColor(1)),
          ),
        ),
        Tab(
          child: Text(
            "Outbound",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _getLabelColor(2)),
          ),
        ),
        Tab(
          child: Text(
            "In-plant Material Movement",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _getLabelColor(3)),
          ),
        ),
      ],
    );
  }
}













