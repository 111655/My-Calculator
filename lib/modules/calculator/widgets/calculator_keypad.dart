import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/button_data.dart';
import '../controller/calculator_controller.dart';
import 'calculator_button.dart';
import 'memory_bar.dart';
import 'scientific_panel.dart';

class CalculatorKeypad extends GetView<CalculatorController> {
  final bool isTablet;

  const CalculatorKeypad({
    super.key,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final spacing = isTablet ? 14.0 : 8.0;

        return SingleChildScrollView(
          child: Column(
            children: [
              const MemoryBar(),

              const SizedBox(height: 10),
              const ScientificPanel(),

              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (_, index) {
                  final button = buttons[index];

                  return CalculatorButton(
                    text: button.text,
                    isOperator:
                    button.isOperator && button.text != "=",
                    isEqual: button.text == "=",
                    onTap: () {
                      controller.onButtonPressed(button.text);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}