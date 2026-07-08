import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/scientific_button_data.dart';
import '../controller/calculator_controller.dart';
import 'calculator_button.dart';

class ScientificPanel extends GetView<CalculatorController> {
  const ScientificPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: scientificButtons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: isTablet ? 1.4 : 1.25,
        ),
        itemBuilder: (context, index) {
          final button = scientificButtons[index];

          return CalculatorButton(
            text: button.text,
            isOperator: true,
            onTap: () => controller.onButtonPressed(button.text),
          );
        },
      ),
    );
  }
}