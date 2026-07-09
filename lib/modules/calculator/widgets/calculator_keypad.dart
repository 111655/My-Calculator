import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/button_data.dart';
import '../controller/calculator_controller.dart';
import 'calculator_button.dart';

class CalculatorKeypad extends GetView<CalculatorController> {
  const CalculatorKeypad({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final isTablet = media.size.width >= 600;
    final isLandscape =
        media.orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = isLandscape ? 10.0 : 10.0;

        const columns = 4;
        final rows = (buttons.length / columns).ceil();

        final buttonWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        final buttonHeight =
            (constraints.maxHeight - spacing * (rows - 1)) / rows;

        // Portrait uses your existing design.
        // Landscape adapts to available space.
        final aspectRatio = isLandscape
            ? (isTablet ? 1.35 : 1.15)
            : buttonWidth / buttonHeight;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: buttons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (_, index) {
            final button = buttons[index];

            return CalculatorButton(
              text: button.text,
              isOperator: button.isOperator && button.text != "=",
              isEqual: button.text == "=",
              onTap: () => controller.onButtonPressed(button.text),
            );
          },
        );
      },
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   final isTablet = MediaQuery.of(context).size.width >= 600;
//
//   return LayoutBuilder(
//     builder: (context, constraints) {
//       final spacing = isTablet ? 12.0 : 8.0;
//
//       const columns = 4;
//       final rows = (buttons.length / columns).ceil();
//
//       final buttonWidth =
//           (constraints.maxWidth - (columns - 1) * spacing) / columns;
//
//       final buttonHeight =
//           (constraints.maxHeight - (rows - 1) * spacing) / rows;
//
//       return GridView.builder(
//         padding: EdgeInsets.zero,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: buttons.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: columns,
//           crossAxisSpacing: spacing,
//           mainAxisSpacing: spacing,
//           childAspectRatio: buttonWidth / buttonHeight,
//         ),
//         itemBuilder: (context, index) {
//           final button = buttons[index];
//
//           return CalculatorButton(
//             text: button.text,
//             isOperator: button.isOperator && button.text != "=",
//             isEqual: button.text == "=",
//             onTap: () => controller.onButtonPressed(button.text),
//           );
//         },
//       );
//     },
//   );
// }
// }