import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/button_data.dart';
import '../../../app/constants/scientific_button_data.dart';
import '../../history/view/history_page.dart';
import '../../settings/controller/scientific_controller.dart';
import '../../settings/controller/theme_controller.dart';
import '../../settings/view/settings_page.dart';
import '../controller/calculator_controller.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';

class CalculatorPage extends GetView<CalculatorController> {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final scientificController = Get.find<ScientificController>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
        actions: [

          Obx(
                () => IconButton(
              icon: Icon(
                scientificController.isScientific.value
                    ? Icons.calculate
                    : Icons.functions,
              ),
              tooltip: "Scientific Mode",
              onPressed: scientificController.toggle,
            ),
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
        const SizedBox(height: 8),
        Expanded(
          flex: 8,
          child: _buildGrid(isTablet),
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
            padding: const EdgeInsets.only(right: 12),
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
          child: _buildGrid(isTablet),
        ),
      ],
    );
  }

  Widget _buildGrid(bool isTablet) {
    final scientificController = Get.find<ScientificController>();

    return Obx(() {
      final currentButtons = scientificController.isScientific.value
          ? [...scientificButtons, ...buttons]
          : buttons;

      return LayoutBuilder(
        builder: (context, box) {
          final spacing = isTablet ? 14.0 : 8.0;

          final rows = (currentButtons.length / 4).ceil();

          final itemWidth =
              (box.maxWidth - (spacing * 3)) / 4;

          final itemHeight =
              (box.maxHeight - (spacing * (rows - 1))) / rows;

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: currentButtons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) {
              final button = currentButtons[index];

              return CalculatorButton(
                text: button.text,
                isOperator: button.isOperator && button.text != "=",
                isEqual: button.text == "=",
                onTap: () {
                  controller.onButtonPressed(button.text);
                },
              );
            },
          );
        },
      );
    });
  }
}