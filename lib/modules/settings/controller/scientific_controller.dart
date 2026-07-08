import 'package:get/get.dart';

class ScientificController extends GetxController {
  final isExpanded = false.obs;

  void toggle() {
    isExpanded.toggle();
  }

  void open() {
    isExpanded.value = true;
  }

  void close() {
    isExpanded.value = false;
  }
}