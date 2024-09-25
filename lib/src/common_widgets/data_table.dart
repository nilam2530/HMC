import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';

import '../app_configs/app_images.dart';
import '../models/data_table_model.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({super.key});

  @override
  DataTableWidgetState createState() => DataTableWidgetState();
}

class DataTableWidgetState extends State<DataTableWidget> {
  final int _rowsPerPage = 10;
  final Set<int> _expandedRows = <int>{};
  final List<DataTableModel> _requests = List.generate(
    30,
    (index) => DataTableModel(
      date: "20 Jun 2024",
      requestNo: "LRIB${index.toString().padLeft(5, '0')}",
      type: "Inbound",
      modeOfTransportation: "Land - Part",
      status: "Pending Request",
    ),
  );
  int _currentPage = 0;

  void _toggleRowExpansion(int index) {
    setState(() {
      if (_expandedRows.contains(index)) {
        _expandedRows.remove(index);
      } else {
        _expandedRows.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final paginatedRequests =
        _requests.skip(_currentPage * _rowsPerPage).take(_rowsPerPage).toList();
    final totalPages = (_requests.length / _rowsPerPage).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.dark3Grey,
            ),
            child: Row(
              children: [
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Sr No.", style: _textStyle()))),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Date", style: _textStyle()))),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Request No.", style: _textStyle()))),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Type", style: _textStyle()))),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child:
                            Text("Mode Of Transportation", style: _textStyle()))),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Status", style: _textStyle()))),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Actions", style: _textStyle()))),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  paginatedRequests.length,
                  (index) {
                    final request = paginatedRequests[index];
                    final actualIndex = _currentPage * _rowsPerPage + index;
                    final isExpanded = _expandedRows.contains(actualIndex);
                    return Column(
                      children: [
                        DataRowWidget(
                          index: actualIndex,
                          request: request,
                          isExpanded: isExpanded,
                          onTap: () => _toggleRowExpansion(actualIndex),
                        ),
                        if (isExpanded)
                          Container(
                            width: double.maxFinite,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildRequestInfoColumn(),
                                    _buildPickupAndPackageDetailsColumn(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // Divider between rows
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey[300],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          // Pagination controls and index count display
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Page ${_currentPage + 1} of $totalPages'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: _currentPage > 0
                          ? () {
                              setState(() {
                                _currentPage--;
                              });
                            }
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: _currentPage < totalPages - 1
                          ? () {
                              setState(() {
                                _currentPage++;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestInfoColumn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Request Info.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildInfoRow('Section', 'Dgt.Eng&Test.Dev - Rahul BHARADWAJ'),
          _buildInfoRow('Pickup Address', 'Gurugram NIT'),
          _buildInfoRow('Pickup Pincode', '122012'),
          _buildInfoRow('Destination Address', 'CIT Jaipur'),
          _buildInfoRow('Destination Pincode', '302023'),
          _buildInfoRow('Approx Weight', '2 Kg/L'),
          _buildInfoRow('Invoice Value', '1'),
          _buildInfoRow('Mode Of Transportation', 'Land - Part Truck Load'),
        ],
      ),
    );
  }

  Widget _buildPickupAndPackageDetailsColumn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pick Up & Package Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildInfoRow('Pickup Date', '18 July 2024'),
          _buildInfoRow('Contact Person Name', 'Surendar Singh'),
          _buildInfoRow('Contact Person Mobile No.', '9081234521'),
          _buildInfoRow('Attachment', 'xls.file'),
          _buildInfoRow('Number Of Packages', '120'),
          _buildInfoRow('Package Dimensions', '4X4'),
          _buildInfoRow('Document/PO Number', 'PO10120'),
          _buildInfoRow('Special Instructions', 'TEST'),
        ],
      ),
    );
  }

  // Reusable TextStyle method
  TextStyle _textStyle() {
    return const TextStyle(
      fontFamily: 'Gotham-Bold',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 18 / 14,
      // line-height calculated as a multiplier of font size
      color: AppColors.lightBlack, // Adjust color as needed
    );
  }
}

Widget _buildInfoRow(String label, String value) {
  return Row(
    children: [
      SizedBox(
        height: 40,
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.darkGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 40),
      const Text(":"),
      const SizedBox(width: 20),
      Text(value,style: const TextStyle(
         // color: AppColors.TxtColor
        color: AppColors.darkGrey,
        fontWeight: FontWeight.bold,
      ),),
    ],
  );
}

class DataRowWidget extends StatelessWidget {
  final int index;
  final DataTableModel request;
  final bool isExpanded;
  final VoidCallback onTap;

  const DataRowWidget({
    super.key,
    required this.index,
    required this.request,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            color: isExpanded ? Colors.blueGrey[50] : Colors.white,
            child: Row(
              children: [
                Expanded(child: Text("${index + 1}")),
                Expanded(child: Text(request.date)),
                Expanded(child: Text(request.requestNo)),
                Expanded(child: Text(request.type)),
                Expanded(child: Text(request.modeOfTransportation)),
                Expanded(child: Text(request.status)),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: onTap,
                          child: Image.asset(
                            AppImages.downArrowTable,
                            height: 20,
                            width: 20,
                            color: isExpanded ? Colors.red : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.edit),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
