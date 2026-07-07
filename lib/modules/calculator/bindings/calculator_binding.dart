import 'package:get/get.dart';
import '../../history/controller/history_controller.dart';
import '../../settings/controller/scientific_controller.dart';
import '../../settings/controller/theme_controller.dart';
import '../controller/calculator_controller.dart';

class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => CalculatorController(),
      fenix: true,
    );
    Get.lazyPut(() => HistoryController(), fenix: true);
    Get.put(ThemeController(), permanent: true);
    Get.put(ScientificController(), permanent: true,
    );
  }
}