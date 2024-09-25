import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/models/pillar_model.dart';

import '../../../../models/kaizen_pillar_table_model.dart';

class KaizenProvider with ChangeNotifier {
  static const int _rowsPerPage = 10;
  int _currentPage = 0;
  final TextEditingController plantNameController = TextEditingController();
  final TextEditingController pillarNameController = TextEditingController();
  final TextEditingController pillarHeadECNoController =
      TextEditingController();
  final TextEditingController sortOrderController = TextEditingController();
  String selectedPillarHead = '';
  List<KaizenPillarTableModel> newData = List.generate(
    50,
    (index) => KaizenPillarTableModel(
      id: (index + 1).toString(),
      plantName: "Plant ${index + 1}",
      pillarHeadECNo: "EC${(index + 100).toString().padLeft(3, '0')}",
      sortNo: (index + 1).toString(),
      status: index % 2 == 0 ? "Pending" : "Completed",
      action: "Action ${index + 1}",
      pillarName: "Pillar ${index % 3 + 1}",
    ),
  );

  List<KaizenPillarTableModel> get paginatedData {
    final start = _currentPage * _rowsPerPage;
    final end = start + _rowsPerPage;
    return newData.sublist(start, end.clamp(0, newData.length));
  }

  List<PillarModel> pillarModel = [
    PillarModel(title: 'Head 1'),
    PillarModel(title: 'Head 2'),
  ];

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  int get totalPages => (newData.length / _rowsPerPage).ceil();

  void addNewPillar({
    required String plantName,
    required String pillarName,
    required String pillarHeadECNo,
    required String sortOrder,
    required String status,
  }) {
    final newPillar = KaizenPillarTableModel(
      id: (newData.length + 1).toString(),
      plantName: plantName,
      pillarName: pillarName,
      pillarHeadECNo: pillarHeadECNo,
      sortNo: sortOrder,
      status: status,
      action: "Action ${newData.length + 1}",
    );

    newData.add(newPillar);

    plantNameController.clear();
    pillarNameController.clear();
    pillarHeadECNoController.clear();
    sortOrderController.clear();
    selectedPillarHead = '';
    notifyListeners();
  }

  void setSelectedPillarHead(String value) {
    selectedPillarHead = value;
    notifyListeners();
  }
}
