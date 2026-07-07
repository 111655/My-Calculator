import 'package:get/get.dart';

class ScientificController extends GetxController {
  final isScientific = false.obs;

  void toggle() {
    isScientific.toggle();
  }
}