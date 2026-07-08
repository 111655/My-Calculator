import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../history/view/history_page.dart';
import '../../settings/controller/scientific_controller.dart';
import '../../settings/view/settings_page.dart';
import '../controller/calculator_controller.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';
import '../widgets/memory_bar.dart';
import '../widgets/scientific_panel.dart';

class CalculatorPage extends GetView<CalculatorController> {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Get.to(() => const HistoryPage()),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.to(() => const SettingsPage()),
          ),
        ],
      ),
      body: SafeArea(
        child: isLandscape
            ? _buildLandscape(context)
            : _buildPortrait(context),
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
                  child: showScientific
                      ? const ScientificPanel()
                      : const SizedBox.shrink(),
                ),

                if (showScientific)
                  const SizedBox(height: 8),

                const Expanded(
                  child: CalculatorKeypad(),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildLandscape(BuildContext context) {
    final scientific = Get.find<ScientificController>();

    return Row(
      children: [

        Expanded(
          flex: 4,
          child: Obx(
                () => CalculatorDisplay(
              expression: controller.expression.value,
              result: controller.result.value,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          flex: 6,
          child: Column(
            children: [

              const MemoryBar(),

              const SizedBox(height: 8),

              Expanded(
                child: Obx(() {
                  final showScientific = scientific.isScientific.value;

                  return Row(
                    children: [

                      if (showScientific)
                        Expanded(
                          flex: 4,
                          child: const ScientificPanel(),
                        ),

                      if (showScientific)
                        const SizedBox(width: 8),

                      const Expanded(
                        flex: 6,
                        child: CalculatorKeypad(),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}