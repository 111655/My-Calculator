import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../history/view/history_page.dart';
import '../../settings/controller/scientific_controller.dart';
import '../../settings/view/settings_page.dart';
import '../controller/calculator_controller.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';
import '../widgets/memory_action.dart';
import '../widgets/memory_bar.dart';
import '../widgets/scientific_panel.dart';

class CalculatorPage extends GetView<CalculatorController> {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("My Calculator"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
          fontSize: 20,
        ),
        centerTitle: false,
        actions: [
          if (isLandscape) ...[MemoryActions(), const SizedBox(width: 70)],
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: controller.shareCalculation,
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Get.to(() => const HistoryPage()),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.to(() => const SettingsPage()),
          ),
        ],
      ),
      body: SafeArea(
        child: isLandscape ? _buildLandscape(context) : _buildPortrait(context),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    final scientific = Get.find<ScientificController>();

    return Column(
      children: [
        // Fixed Display
        SizedBox(
          height: 160,
          child: Obx(
            () => CalculatorDisplay(
              expression: controller.expression.value,
              result: controller.result.value,
            ),
          ),
        ),

        // Fixed Memory Bar
        const SizedBox(height: 4),
        const MemoryBar(),
        const SizedBox(height: 3),
        // Remaining Area
        Expanded(
          child: Obx(() {
            final showScientific = scientific.isScientific.value;

            return Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: showScientific ? 180 : 0,
                  child:
                      showScientific
                          ? const ScientificPanel()
                          : const SizedBox.shrink(),
                ),

                if (showScientific) const SizedBox(height: 8),

                const Expanded(child: CalculatorKeypad()),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildLandscape(BuildContext context) {
    final scientificController = Get.find<ScientificController>();

    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
      child: Row(
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
          SizedBox(width: 10),
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(flex: 6, child: ScientificPanel(isLandscape: true)),

                const SizedBox(width: 20),

                const Expanded(flex: 6, child: CalculatorKeypad()),
              ],
            ),
          ),

          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
