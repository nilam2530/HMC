import 'package:flutter/material.dart';

class CustomDataTableWidget<T> extends StatefulWidget {
  final List<T> data;
  final List<String> columnTitles;
  final List<Widget Function(T)> columnBuilders;
  final List<Widget> Function(T)? expandedContentBuilder;
  final int rowsPerPage;
  final TextStyle? headerStyle;
  final TextStyle? cellStyle;
  final TextStyle? columnTitlesStyle;
  final bool expandableRows;
  final Color? evenRowColor;
  final Color? oddRowColor;
  final String Function(T)? statusExtractor;


  const CustomDataTableWidget({
    super.key,
    required this.data,
    required this.columnTitles,
    required this.columnBuilders,
    this.expandedContentBuilder,
    this.rowsPerPage = 10,
    this.headerStyle,
    this.cellStyle,
    this.expandableRows = false,
    this.statusExtractor,
    this.columnTitlesStyle,
    this.evenRowColor = const Color(0xFFF0F0F0),
    this.oddRowColor = Colors.white,
  });

  @override
  _CustomDataTableWidgetState<T> createState() =>
      _CustomDataTableWidgetState<T>();
}

class _CustomDataTableWidgetState<T> extends State<CustomDataTableWidget<T>> {
  final Set<int> _expandedRows = <int>{};
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
    final paginatedData = widget.data
        .skip(_currentPage * widget.rowsPerPage)
        .take(widget.rowsPerPage)
        .toList();
    final totalPages = (widget.data.length / widget.rowsPerPage).ceil();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          _buildHeaderRow(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  paginatedData.length,
                      (index) {
                    final dataItem = paginatedData[index];
                    final actualIndex =
                        _currentPage * widget.rowsPerPage + index;
                    final isExpanded = _expandedRows.contains(actualIndex);
                    return Column(
                      children: [
                        _buildDataRow(dataItem, actualIndex, isExpanded),
                        if (isExpanded && widget.expandedContentBuilder != null)
                          _buildExpandedRow(dataItem),
                        Divider(
                            thickness: 1, height: 1, color: Colors.grey[300]),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          // Pagination Controls
          _buildPaginationControls(totalPages),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: List.generate(widget.columnTitles.length + 1, (index) {
          if (index == widget.columnTitles.length) {
            return const Expanded(
              child: Text(
                'Action',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            );
          }
          return Expanded(
            child: Text(
              widget.columnTitles[index],
              style: widget.headerStyle ??
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDataRow(T dataItem, int index, bool isExpanded) {
    return GestureDetector(
      onTap: widget.expandableRows ? () => _toggleRowExpansion(index) : null,
      child: Container(
        color: index % 2 == 0 ? widget.evenRowColor : widget.oddRowColor,
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children:
          List.generate(widget.columnBuilders.length + 1, (columnIndex) {
            if (columnIndex == widget.columnBuilders.length) {
              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                        size: 16,
                      ),
                      onPressed: () {
                        _toggleRowExpansion(index);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 16,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }

            return Expanded(
              child: widget.columnBuilders[columnIndex](dataItem),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildExpandedRow(T dataItem) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.expandedContentBuilder!(dataItem),
      ),
    );
  }

  Widget _buildPaginationControls(int totalPages) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Page ${_currentPage + 1} of $totalPages'),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 14,
                ),
                onPressed: _currentPage > 0
                    ? () {
                  setState(() {
                    _currentPage--;
                  });
                }
                    : null,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
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
    );
  }
}


// import 'package:flutter/material.dart';
//
// class CustomDataTableWidget<T> extends StatefulWidget {
//   final List<T> data;
//   final List<String> columnTitles;
//   final List<Widget Function(T)> columnBuilders;
//   final List<Widget> Function(T)? expandedContentBuilder;
//   final int rowsPerPage;
//   final TextStyle? headerStyle;
//   final TextStyle? cellStyle;
//   final TextStyle? columnTitlesStyle;
//   final bool expandableRows;
//   final Color? evenRowColor;
//   final Color? oddRowColor;
//   final String Function(T)? statusExtractor;
//
//   const CustomDataTableWidget({
//     super.key,
//     required this.data,
//     required this.columnTitles,
//     required this.columnBuilders,
//     this.expandedContentBuilder,
//     this.rowsPerPage = 10,
//     this.headerStyle,
//     this.cellStyle,
//     this.expandableRows = false,
//     this.statusExtractor,
//     this.columnTitlesStyle,
//     this.evenRowColor = const Color(0xFFF0F0F0),
//     this.oddRowColor = Colors.white,
//   });
//
//   @override
//   _CustomDataTableWidgetState<T> createState() =>
//       _CustomDataTableWidgetState<T>();
// }
//
// class _CustomDataTableWidgetState<T> extends State<CustomDataTableWidget<T>> {
//   final Set<int> _expandedRows = <int>{};
//   final Set<int> _selectedRows =
//       <int>{};
//   int _currentPage = 0;
//
//   void _toggleRowExpansion(int index) {
//     setState(() {
//       if (_expandedRows.contains(index)) {
//         _expandedRows.remove(index);
//       } else {
//         _expandedRows.add(index);
//       }
//     });
//   }
//
//   void _toggleCheckboxSelection(int index) {
//     setState(() {
//       if (_selectedRows.contains(index)) {
//         _selectedRows.remove(index);
//       } else {
//         _selectedRows.add(index);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final paginatedData = widget.data
//         .skip(_currentPage * widget.rowsPerPage)
//         .take(widget.rowsPerPage)
//         .toList();
//     final totalPages = (widget.data.length / widget.rowsPerPage).ceil();
//
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Column(
//         children: [
//           _buildHeaderRow(),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: List.generate(
//                   paginatedData.length,
//                   (index) {
//                     final dataItem = paginatedData[index];
//                     final actualIndex =
//                         _currentPage * widget.rowsPerPage + index;
//                     final isExpanded = _expandedRows.contains(actualIndex);
//                     return Column(
//                       children: [
//                         _buildDataRow(dataItem, actualIndex, isExpanded),
//                         if (isExpanded && widget.expandedContentBuilder != null)
//                           _buildExpandedRow(dataItem),
//                         Divider(
//                           thickness: 1,
//                           height: 1,
//                           color: Colors.grey[300],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//           _buildPaginationControls(totalPages),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeaderRow() {
//     return Container(
//       color: Colors.grey[300],
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(widget.columnTitles.length + 1, (index) {
//           if (index == widget.columnTitles.length) {
//             return const Expanded(
//               child: Text(
//                 'Action',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 textAlign: TextAlign.center,
//               ),
//             );
//           }
//
//           // Customize header for each column
//           return Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (index == 0) // Checkbox in Id column
//                   Checkbox(
//                     value: _selectedRows.length == widget.data.length,
//                     onChanged: (value) {
//                       setState(() {
//                         if (value == true) {
//                           _selectedRows.addAll(List.generate(
//                               widget.data.length, (index) => index));
//                         } else {
//                           _selectedRows.clear();
//                         }
//                       });
//                     },
//                   ),
//                 Text(
//                   widget.columnTitles[index],
//                   style: widget.headerStyle ??
//                       const TextStyle(
//                           fontWeight: FontWeight.w500, fontSize: 14),
//                 ),
//                 if (index > 0) // Filter icon for columns other than Id
//                   IconButton(
//                     icon: const Icon(Icons.filter_list),
//                     onPressed: () {
//                       // Handle filter functionality here
//                     },
//                     iconSize: 16,
//                   ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildDataRow(T dataItem, int index, bool isExpanded) {
//     return GestureDetector(
//       onTap: widget.expandableRows ? () => _toggleRowExpansion(index) : null,
//       child: Container(
//         color: index % 2 == 0 ? widget.evenRowColor : widget.oddRowColor,
//         padding: const EdgeInsets.symmetric(vertical: 2.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.min, // Minimize space usage
//           children:
//               List.generate(widget.columnBuilders.length + 1, (columnIndex) {
//             if (columnIndex == widget.columnBuilders.length) {
//               return Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       icon: const Icon(
//                         Icons.edit,
//                         color: Colors.green,
//                         size: 16,
//                       ),
//                       onPressed: () {
//                         _toggleRowExpansion(index);
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                         size: 16,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             if (columnIndex == 0) {
//               // Checkbox for each row in the first column
//               return Expanded(
//                 child: Checkbox(
//                   value: _selectedRows.contains(index),
//                   onChanged: (value) {
//                     _toggleCheckboxSelection(index);
//                   },
//                 ),
//               );
//             }
//
//             return Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 8.0), // Add padding for better alignment
//                 child: widget.columnBuilders[columnIndex](dataItem),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildExpandedRow(T dataItem) {
//     return Container(
//       color: Colors.white,
//       width: double.infinity,
//       padding: const EdgeInsets.all(5.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: widget.expandedContentBuilder!(dataItem),
//       ),
//     );
//   }
//
//   Widget _buildPaginationControls(int totalPages) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('Page ${_currentPage + 1} of $totalPages'),
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back_ios,
//                   size: 14,
//                 ),
//                 onPressed: _currentPage > 0
//                     ? () {
//                         setState(() {
//                           _currentPage--;
//                         });
//                       }
//                     : null,
//               ),
//               IconButton(
//                 icon: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 14,
//                 ),
//                 onPressed: _currentPage < totalPages - 1
//                     ? () {
//                         setState(() {
//                           _currentPage++;
//                         });
//                       }
//                     : null,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

