import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../history/view/history_page.dart';
import '../../settings/controller/scientific_controller.dart';
import '../../settings/controller/theme_controller.dart';
import '../../settings/view/settings_page.dart';
import '../controller/calculator_controller.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';

class CalculatorPage extends GetView<CalculatorController> {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final scientificController = Get.find<ScientificController>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
        actions: [

          IconButton(
            icon: const Icon(Icons.share),
            onPressed: controller.shareCalculation,
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Get.to(() => const HistoryPage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(() => const SettingsPage());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            return Padding(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              child: isLandscape
                  ? _buildLandscape(context, isTablet)
                  : _buildPortrait(context, isTablet),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context, bool isTablet) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Obx(
                () => CalculatorDisplay(
              expression: controller.expression.value,
              result: controller.result.value,
            ),
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          flex: 7,
          child: CalculatorKeypad(
            isTablet: isTablet,
          ),
        ),
      ],
    );
  }

  Widget _buildLandscape(BuildContext context, bool isTablet) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Obx(
                  () => CalculatorDisplay(
                expression: controller.expression.value,
                result: controller.result.value,
              ),
            ),
          ),
        ),

        Expanded(
          flex: 6,
          child: CalculatorKeypad(
            isTablet: isTablet,
          ),
        ),
      ],
    );
  }
}