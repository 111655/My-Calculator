import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/services/export_service.dart';
import '../../../data/services/models/history_model.dart';
import '../../calculator/controller/calculator_controller.dart';

class HistoryController extends GetxController {
  final Box _box = Hive.box('calculator_history');
  final searchQuery = ''.obs;
  final RxList<HistoryModel> history = <HistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  //================ LOAD HISTORY =================

  void loadHistory() {
    history.clear();

    final items = _box.values.toList().reversed;

    for (final item in items) {
      history.add(
        HistoryModel(
          expression: item['expression'] as String,
          result: item['result'] as String,
          time: DateTime.parse(item['time'] as String),
          isFavorite: item['favorite'] ?? false,
        ),
      );
    }
    history.sort((a, b) {
      if (a.isFavorite == b.isFavorite) {
        return b.time.compareTo(a.time);
      }
      return a.isFavorite ? -1 : 1;
    });
  }

  //================ ADD HISTORY =================

  void addHistory(String expression, String result) {
    final data = {
      "expression": expression,
      "result": result,
      "time": DateTime.now().toIso8601String(),
      "favorite": false,
    };

    _box.add(data);

    history.insert(
      0,
      HistoryModel(
        expression: expression,
        result: result,
        time: DateTime.now(),
      ),
    );
  }

  //================ DELETE HISTORY =================

  void deleteHistory(int index) {
    if (index < 0 || index >= history.length) return;

    final key = _box.keyAt(_box.length - 1 - index);

    _box.delete(key);

    history.removeAt(index);

    Get.snackbar(
      "Deleted",
      "Calculation removed successfully",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  //================ CLEAR HISTORY =================

  void clearHistory() {
    _box.clear();
    history.clear();

    Get.snackbar(
      "History Cleared",
      "All calculations have been removed",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  //================ COPY RESULT =================

  Future<void> copyResult(String result) async {
    await Clipboard.setData(
      ClipboardData(text: result),
    );

    Get.snackbar(
      "Copied",
      "Result copied to clipboard",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  //================ REUSE HISTORY =================

  void useCalculation(int index) {
    if (index < 0 || index >= history.length) return;

    Get.back(result: history[index].result);
  }

  //=========================use calcculation =====================
  void useCalculation2(HistoryModel item) {
    Get.back();

    final calculator = Get.find<CalculatorController>();

    calculator.expression.value = item.expression;
    calculator.result.value = item.result;
  }

  //=============search history =======================
  List<HistoryModel> get filteredHistory {
    if (searchQuery.value.isEmpty) {
      return history;
    }

    return history.where((item) {
      return item.expression
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()) ||
          item.result
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  void toggleFavorite(HistoryModel item) {
    final key = _box.keys.firstWhere(
          (k) {
        final data = _box.get(k);

        return data['expression'] == item.expression &&
            data['result'] == item.result &&
            data['time'] == item.time.toIso8601String();
      },
    );

    final data = Map<String, dynamic>.from(_box.get(key));

    data['favorite'] = !(data['favorite'] ?? false);

    _box.put(key, data);

    loadHistory();
  }

  int get totalCalculations => history.length;

  int get favoriteCalculations =>
      history.where((e) => e.isFavorite).length;

  int get todayCalculations {
    final now = DateTime.now();

    return history.where((e) {
      return e.time.year == now.year &&
          e.time.month == now.month &&
          e.time.day == now.day;
    }).length;
  }

  int get thisWeekCalculations {
    final now = DateTime.now();

    return history.where((e) {
      return now.difference(e.time).inDays < 7;
    }).length;
  }

  Future<void> exportHistory() async {
    if (history.isEmpty) {
      Get.snackbar(
        "No History",
        "Nothing to export.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    await ExportService.exportHistory(history);
  }
}