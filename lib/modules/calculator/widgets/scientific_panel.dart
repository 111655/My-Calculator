import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/scientific_button_data.dart';
import '../controller/calculator_controller.dart';
import 'calculator_button.dart';

class ScientificPanel extends GetView<CalculatorController> {
  final bool isLandscape;

  const ScientificPanel({
    super.key,
    this.isLandscape = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    final isTablet = media.size.width >= 600;

    final spacing = isTablet ? 12.0 : 10.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isLandscape ? 10 : 5),
      margin: EdgeInsets.only(bottom: isLandscape ? 0 : 0),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = isLandscape ? 5 : 5;

          // final rows =
          // (scientificButtons.length / crossAxisCount).ceil();

          // final buttonWidth =
          //     (constraints.maxWidth -
          //         spacing * (crossAxisCount - 1)) /
          //         crossAxisCount;
          //
          // final buttonHeight =
          //     (constraints.maxHeight -
          //         spacing * (rows - 1)) /
          //         rows;

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: scientificButtons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
             childAspectRatio: isLandscape
              ? (isTablet ? 2.2 : 2.0)
              : (isTablet ? 1.4 : 1.25),         //buttonWidth / buttonHeight,
            ),
            itemBuilder: (_, index) {
              final button = scientificButtons[index];

              return CalculatorButton(
                text: button.text,
                isOperator: true,
                onTap: () => controller.onButtonPressed(button.text),
              );
            },
          );
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../app/constants/scientific_button_data.dart';
// import '../controller/calculator_controller.dart';
// import 'calculator_button.dart';
//
// class ScientificPanel extends GetView<CalculatorController> {
//
//   final bool isLandscape;
//
//   const ScientificPanel({
//     super.key,
//     this.isLandscape = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isTablet = MediaQuery.of(context).size.width >= 600;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: GridView.builder(
//         padding: EdgeInsets.zero,
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: scientificButtons.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: isLandscape ? 2 : 5,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//           childAspectRatio: isLandscape
//               ? (isTablet ? 2.2 : 2.0)
//               : (isTablet ? 1.4 : 1.25),
//         ),
//         itemBuilder: (context, index) {
//           final button = scientificButtons[index];
//
//           return CalculatorButton(
//             text: button.text,
//             isOperator: true,
//             onTap: () => controller.onButtonPressed(button.text),
//           );
//         },
//       ),
//     );
//   }
// }