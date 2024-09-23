import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Filter {
  static void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        bool isExpanded = false;
        DateTimeRange? _dateRange;
        List<String>? _modeOfTransportation;
        List<String>? _status;
        final _dateController = TextEditingController();

        const List<String> _modeOfTransportationList = [
          'All',
          'Car',
          'Bus',
          'Train',
          'Airplane',
        ];

        const List<String> _statusList = [
          'All',
          'Pending',
          'Approved',
          'Rejected',
        ];

        Future<List<String>> _getFakeModeOfTransportationData(String query) async {
          return await Future.delayed(const Duration(seconds: 1), () {
            return _modeOfTransportationList.where((e) {
              return e.toLowerCase().contains(query.toLowerCase());
            }).toList();
          });
        }

        Future<List<String>> _getFakeStatusData(String query) async {
          return await Future.delayed(const Duration(seconds: 1), () {
            return _statusList.where((e) {
              return e.toLowerCase().contains(query.toLowerCase());
            }).toList();
          });
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 416,
                    height: 394,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(width: 1), // Removed outline border
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          // Filter Title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Filter',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF131E29)),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          // Added line break after filter heading
                          SizedBox(height: 8),
                          // Request Date row
                          Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Request Date', style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF525252))),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                    hintText: 'Select date',
                                    hintStyle: TextStyle(color: Color(0xFF131E29), fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  onTap: () async {
                                    final List<DateTime>? picked = (await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030),
                                      initialEntryMode: DatePickerEntryMode.calendar,
                                      initialDateRange: _dateRange,
                                    )) as List<DateTime>?;
                                    if (picked != null && picked.length == 2) {
                                      setState(() {
                                        _dateRange = DateTimeRange(
                                          start: picked[0],
                                          end: picked[1],
                                        );
                                        _dateController.text =
                                        '${DateFormat('d MMM yyyy').format(_dateRange!.start)} - ${DateFormat('d MMM yyyy').format(_dateRange!.end)}';
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Mode of Transportation row
                          Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mode of transportation', style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF525252))),
                                SizedBox(height: 8),
                                CustomDropdown<String>.multiSelectSearchRequest(
                                  items: _modeOfTransportationList,
                                  futureRequest: _getFakeModeOfTransportationData,
                                  hintText: 'Select',
                                  onListChanged: (value) {
                                    setState(() {
                                      if (value.contains('All')) {
                                        _modeOfTransportation = _modeOfTransportationList;
                                      } else {
                                        _modeOfTransportation = value;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Status row
                          Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Status', style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF525252))),
                                SizedBox(height: 8),
                                // Modified to show dropdown below
                                CustomDropdown<String>.multiSelectSearchRequest(
                                  items: _statusList,
                                  futureRequest: _getFakeStatusData,
                                  hintText: 'Select',
                                  onListChanged: (value) {
                                    setState(() {
                                      if (value.contains('All')) {
                                        _status = _statusList;
                                      } else {
                                        _status = value;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Buttons row
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Reset logic here
                                      setState(() {
                                        _dateRange = null;
                                        _modeOfTransportation = null;
                                        _status = null;
                                        _dateController.text = '';
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      // minimumSize: const Size(565, 73), // width and height
                                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                      textStyle: const TextStyle(fontSize: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.0),
                                        side: const BorderSide(color: Color(0xFF222222), width: 1), // Border color
                                      ),
                                    ),
                                    child: Text('Reset',
                                      style: TextStyle(
                                        color: Color(0xFF222222)
                                      ),),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Apply logic here
                                      // print('Date Range: $_dateRange');
                                      // print('Mode of Transportation: ${_modeOfTransportation?.join(', ')}');
                                      // print('Status: ${_status?.join(', ')}');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      //minimumSize: const Size(565, 73), // width and height
                                      backgroundColor: const Color(0xFFBD001C), // Red color
                                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                      textStyle: const TextStyle(fontSize: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.0),
                                  
                                        // side: const BorderSide( width: 1), // Border color
                                      ),
                                    ),
                                    child: const Text('Submit',
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF)
                                      ),),
                                  ),
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
            );
          },
        );
      },
    );
  }
}