import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class FilterDialogContent extends StatefulWidget {
  const FilterDialogContent({super.key});

  @override
  createState() => FilterDialogContentState();
}

class FilterDialogContentState extends State<FilterDialogContent> {
  DateTimeRange? _dateRange;
  List<String>? status;
  final _dateController = TextEditingController();

  static const List<String> _statusList = ['Approved', 'Rejected'];

  Future<List<String>> _getFakeStatusData(String query) async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () => _statusList
          .where((e) => e.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF131E29)),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDateField(context),
          const SizedBox(height: 16),
          _buildDropdownField('Mode of transportation', _statusList),
          const SizedBox(height: 16),
          _buildDropdownField('Status', _statusList),
          const SizedBox(height: 30),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Request Date',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF525252))),
        const SizedBox(height: 8),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
          ),
          child: TextFormField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Select date',
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.black, fontSize: 12),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/images/calendra.svg",
                    color: const Color(0xFF131E29)),
              ),
            ),
            onTap: () => _showCustomDateRangePicker(context),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF525252))),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: CustomDropdown<String>.multiSelectSearchRequest(
            items: items,
            futureRequest: _getFakeStatusData,
            hintText: 'Select',
            decoration: const CustomDropdownDecoration(
              hintStyle: TextStyle(fontSize: 12),
              closedFillColor: Color(0xFFF2F2F2),
              listItemStyle: TextStyle(fontSize: 12, color: Colors.black),
            ),
            onListChanged: (value) {
              setState(() {
                status = value.contains('All') ? items : value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonReset('Reset', Colors.white, () {}),
        const SizedBox(width: 10),
        _buildButton(
            'Apply', const Color(0xFFBD001C), () => Navigator.pop(context)),
      ],
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonReset(String text, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomDateRangePicker(BuildContext context) async {
    final DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      initialDateRange: _dateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SizedBox(
            width: 340,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Select Date Range',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    child ?? const SizedBox(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (pickedRange != null) {
      setState(() {
        _dateRange = pickedRange;
        _dateController.text =
            '${DateFormat('d MMM yyyy').format(_dateRange!.start)} - ${DateFormat('d MMM yyyy').format(_dateRange!.end)}';
      });
    }
  }
}
