import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/button_data.dart';
import '../controller/calculator_controller.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';

class CalculatorPage extends GetView<CalculatorController> {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            return Padding(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              child: Column(
                children: [
                  /// Display Area
                  Expanded(
                    flex: 3,
                    child: Obx(
                          () => CalculatorDisplay(
                        expression: controller.expression.value,
                        result: controller.result.value,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Button Grid
                  Expanded(
                    flex: 7,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: isTablet ? 16 : 10,
                        mainAxisSpacing: isTablet ? 16 : 10,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final button = buttons[index];

                        return CalculatorButton(
                          text: button.text,
                          isOperator:
                          button.isOperator && button.text != "=",
                          isEqual: button.text == "=",
                          onTap: () {
                            // Calculator logic will be added
                            controller.onButtonPressed(button.text);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}