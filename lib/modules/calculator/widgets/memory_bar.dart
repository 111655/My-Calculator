import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../settings/controller/scientific_controller.dart';
import '../controller/calculator_controller.dart';
import '../controller/memory_controller.dart';

class MemoryBar extends GetView<CalculatorController> {
  const MemoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    final memory = Get.find<MemoryController>();
    final scientific = Get.find<ScientificController>();
    final theme = Theme.of(context);

    final media = MediaQuery.of(context);

    final isLandscape =
        media.orientation == Orientation.landscape;

    final isTablet = media.size.width >= 600;

    Widget memoryButton({
      required String text,
      required VoidCallback onTap,
      bool selected = false,
      IconData? icon,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: SizedBox(
          height: isLandscape
              ? (isTablet ? 42 : 36)
              : (isTablet ? 46 : 40),
          child: FilledButton.tonal(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.symmetric(
                horizontal: isLandscape ? 8 : 8,
              ),
              backgroundColor: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surface,
              foregroundColor: selected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: icon != null
                ? Icon(icon, size: isLandscape ? 18 : 20)
                : Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isLandscape ? 12 : 13,
              ),
            ),
          ),
        ),
      );
    }

    return Obx(
          () => Container(
        margin: EdgeInsets.only(
          bottom: isLandscape ? 6 : 8,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isLandscape ? 2 : 4,
        ),
        child: Row(
          children: [
            // Scientific Toggle
            memoryButton(
              text: "",
              icon: Icons.functions,
              selected: scientific.isScientific.value,
              onTap: scientific.toggle,
            ),

            memoryButton(
              text: "MC",
              onTap: memory.clear,
            ),

            memoryButton(
              text: "MR",
              selected: memory.hasMemory,
              onTap: () {
                final value = memory.recall().toString();
                controller.expression.value = value;
                controller.result.value = value;
              },
            ),

            memoryButton(
              text: "MS",
              onTap: () {
                memory.store(
                  double.tryParse(controller.result.value) ?? 0,
                );
              },
            ),

            memoryButton(
              text: "M+",
              onTap: () {
                memory.add(
                  double.tryParse(controller.result.value) ?? 0,
                );
              },
            ),

            memoryButton(
              text: "M-",
              onTap: () {
                memory.subtract(
                  double.tryParse(controller.result.value) ?? 0,
                );
              },
            ),

            const Spacer(),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child:      //memory.hasMemory ?
                   Container(
                     width: 105,
                key: ValueKey(memory.memory.value),
                padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? 8 : 10,
                  vertical: isLandscape ? 4 : 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: Text("M: ${memory.memory.value}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                    isLandscape ? 12 : 12,
                    color: theme.colorScheme
                        .onPrimaryContainer,
                  ),
                ),
              )
                  //: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../settings/controller/scientific_controller.dart';
// import '../controller/calculator_controller.dart';
// import '../controller/memory_controller.dart';
//
// class MemoryBar extends GetView<CalculatorController> {
//   const MemoryBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final memory = Get.find<MemoryController>();
//     final scientific = Get.find<ScientificController>();
//     final theme = Theme.of(context);
//
//     Widget button({
//       required String text,
//       required VoidCallback onTap,
//       bool selected = false,
//     }) {
//       return Expanded(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 2),
//           child: FilledButton.tonal(
//             onPressed: onTap,
//             style: FilledButton.styleFrom(
//               backgroundColor: selected
//                   ? theme.colorScheme.primary
//                   : theme.colorScheme.surface,
//               foregroundColor: selected
//                   ? theme.colorScheme.onPrimary
//                   : theme.colorScheme.onSurface,
//               minimumSize: const Size(0, 42),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               text,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//
//     return Obx(
//           () => Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         child: Row(
//           children: [
//             button(
//               text: "MC",
//               onTap: memory.clear,
//             ),
//
//             button(
//               text: "MR",
//               selected: memory.hasMemory,
//               onTap: () {
//                 controller.expression.value =
//                     memory.recall().toString();
//                 controller.result.value =
//                     memory.recall().toString();
//               },
//             ),
//
//             button(
//               text: "MS",
//               onTap: () {
//                 memory.store(
//                   double.tryParse(controller.result.value) ?? 0,
//                 );
//               },
//             ),
//
//             button(
//               text: "M+",
//               onTap: () {
//                 memory.add(
//                   double.tryParse(controller.result.value) ?? 0,
//                 );
//               },
//             ),
//
//             button(
//               text: "M-",
//               onTap: () {
//                 memory.subtract(
//                   double.tryParse(controller.result.value) ?? 0,
//                 );
//               },
//             ),
//
//             button(
//               text: "ƒx",
//               selected: scientific.isScientific.value,
//               onTap: scientific.toggle,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }