import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import '../../../common_widgets/data_table.dart';
import '../../../common_widgets/summary_card.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  bool isDrawerOpen = false;
  bool isExpanded = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  final _formKey = GlobalKey<FormState>();
  DateTimeRange? _dateRange;
  String? _modeOfTransportation = 'All';
  String? _status = 'All';
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

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
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  String? _selectedMode;
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double drawerWidth = isDrawerOpen ? screenWidth * 0.3 : screenWidth * 0.2;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(context),
                      SizedBox(height: isMobile ? 8 : 10),
                      _buildSummaryCards(isMobile),
                      const SizedBox(height: 10),
                      _buildSearchAndActions(isMobile),
                      const SizedBox(height: 20),
                      _buildRequestTabs(isMobile),
                      const SizedBox(height: 10),
                      const Expanded(child: DataTableWidget()),
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

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: AppColors.darBlack,
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
                  _selectedDate != null && _selectedTime != null
                      ? '${DateFormat('d MMM yyyy').format(_selectedDate!)} at ${_selectedTime!.format(context)}'
                      : "Select Date & Time",
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
        SummaryCard(
          bgImg: Image.asset(AppImages.bgImgCard1),
          iconBackgroundColor: AppColors.bgPenDing,
          imagePath: AppImages.summaryVector,
          value: '40',
          label: 'Pending Requests',
          backgroundColor: AppColors.penDingColors,
        ),
        SummaryCard(
          bgImg: Image.asset(AppImages.bgImgCard2),
          imagePath: AppImages.summaryVector,
          value: '25',
          label: 'Completed Requests',
          backgroundColor: AppColors.approvalColors,
          imageSize: 20.0,
          iconBackgroundColor: AppColors.bgApproval,
        ),
        if (!isMobile)
          SummaryCard(
            bgImg: Image.asset(AppImages.bgImgCard),
            imagePath: AppImages.summaryVector,
            value: '33',
            label: 'Completed Requests',
            backgroundColor: AppColors.rejectColors,
            imageSize: 20.0,
            iconBackgroundColor: AppColors.bgReject,
          ),
        SummaryCard(
          bgImg: Image.asset(AppImages.bgImgCard),
          imagePath: AppImages.summaryVector,
          value: '435',
          label: 'Completed Requests',
          backgroundColor: AppColors.completionColors,
          imageSize: 20.0,
          iconBackgroundColor: AppColors.bgComplete,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: const Icon(Icons.search, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.8),
                  child: TextField(
                    decoration: const InputDecoration(
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
        GestureDetector(
          onTap: () => _toggleDropdown(context),
          child: _buildFilterButton(),
        ),
        const SizedBox(width: 16),
        _buildAddRequestButton(),
      ],
    );
  }

  Widget _buildFilterButton() {
    return CompositedTransformTarget(
      link: _layerLink,
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
    return SingleChildScrollView(
      scrollDirection: isMobile ? Axis.vertical : Axis.horizontal,
      child: Row(
        children: [
          Text("All Requests",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.red[900])),
          const SizedBox(width: 20),
          _buildTab("Inbound"),
          const SizedBox(width: 20),
          _buildTab("Outbound"),
          const SizedBox(width: 20),
          _buildTab("In-plant Material Movement"),
        ],
      ),
    );
  }

  Widget _buildTab(String label) {
    return Text(label,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.dark4Grey));
  }

  void _toggleDropdown(BuildContext context) {
    if (isExpanded) {
      // Remove the overlay when it's expanded
      _overlayEntry?.remove();
      _overlayEntry = null; // Reset to prevent it from being removed again
    } else {
      // Create and insert a new overlay entry
      _overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 250, // Adjust width based on your design
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 40), // Offset for the dropdown position
          child: Material(
            elevation: 4.0,
            child: _buildDropdownContent(), // Your custom dropdown content
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownContent() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: _selectedMode,
            hint: const Text('Mode of Transportation'),
            items: ['All', 'Car', 'Bus', 'Train'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedMode = newValue;
              });
            },
          ),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: _selectedStatus,
            hint: const Text('Status'),
            items: ['All', 'Pending', 'Completed'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedStatus = newValue;
              });
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              print('Apply filter with:');
              print('Mode: $_selectedMode');
              print('Status: $_selectedStatus');
              _toggleDropdown(context); // Close the dropdown after applying
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget _showDropdown(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _presentDatePicker(context);
            },
            child: Text(_selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : 'Select Date'),
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: _selectedMode,
            hint: Text('Mode of Transportation'),
            items: <String>['Car', 'Bus', 'Train']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedMode = newValue;
              });
            },
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: _selectedStatus,
            hint: Text('Status'),
            items: <String>['Pending', 'Completed']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedStatus = newValue;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle apply button press
              print('Selected Date: $_selectedDate');
              print('Selected Mode: $_selectedMode');
              print('Selected Status: $_selectedStatus');
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

// Helper widget for Date Range Picker
  Widget _buildDateRangePicker(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Date Range',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        final DateTimeRange? selectedRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          initialDateRange: _dateRange,
        );
        if (selectedRange != null) {
          setState(() {
            _dateRange = selectedRange;
            _dateController.text =
                '${DateFormat('d MMM yyyy').format(selectedRange.start)} - ${DateFormat('d MMM yyyy').format(selectedRange.end)}';
          });
        }
      },
    );
  }

// Helper widget for Time Picker
  Widget _buildTimePicker(BuildContext context) {
    return TextFormField(
      controller: _timeController,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Select Time',
        suffixIcon: Icon(Icons.access_time),
      ),
      onTap: () async {
        final TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (selectedTime != null) {
          setState(() {
            _timeController.text = selectedTime.format(context);
          });
        }
      },
    );
  }

// Helper widget for Dropdown Menu
  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
          .toList(),
      onChanged: onChanged,
    );
  }
}
