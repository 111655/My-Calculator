import 'package:get/get.dart';

class MemoryController extends GetxController {
  final RxDouble memory = 0.0.obs;

  bool get hasMemory => memory.value != 0;

  /// MS - Store
  void store(double value) {
    memory.value = value;
  }

  /// MR - Recall
  double recall() {
    return memory.value;
  }

  /// MC - Clear
  void clear() {
    memory.value = 0;
  }

  /// M+
  void add(double value) {
    memory.value += value;
  }

  /// M-
  void subtract(double value) {
    memory.value -= value;
  }
}