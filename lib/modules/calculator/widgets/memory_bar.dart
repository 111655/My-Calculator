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

    Widget button({
      required String text,
      required VoidCallback onTap,
      bool selected = false,
    }) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: FilledButton.tonal(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              backgroundColor: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surface,
              foregroundColor: selected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              minimumSize: const Size(0, 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return Obx(
          () => Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            button(
              text: "MC",
              onTap: memory.clear,
            ),

            button(
              text: "MR",
              selected: memory.hasMemory,
              onTap: () {
                controller.expression.value =
                    memory.recall().toString();
                controller.result.value =
                    memory.recall().toString();
              },
            ),

            button(
              text: "MS",
              onTap: () {
                memory.store(
                  double.tryParse(controller.result.value) ?? 0,
                );
              },
            ),

            button(
              text: "M+",
              onTap: () {
                memory.add(
                  double.tryParse(controller.result.value) ?? 0,
                );
              },
            ),

            button(
              text: "M-",
              onTap: () {
                memory.subtract(
                  double.tryParse(controller.result.value) ?? 0,
                );
              },
            ),

            button(
              text: "ƒx",
              selected: scientific.isScientific.value,
              onTap: scientific.toggle,
            ),
          ],
        ),
      ),
    );
  }
}