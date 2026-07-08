import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../settings/controller/scientific_controller.dart';
import '../controller/calculator_controller.dart';
import '../controller/memory_controller.dart';

class MemoryActions extends GetView<CalculatorController> {
  const MemoryActions({super.key});

  @override
  Widget build(BuildContext context) {
    final memory = Get.find<MemoryController>();
    final scientific = Get.find<ScientificController>();
    final theme = Theme.of(context);

    Widget actionButton({
      required String text,
      required VoidCallback onTap,
      bool selected = false,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            minimumSize: const Size(32, 32),
            padding: const EdgeInsets.symmetric(horizontal: 8),

            backgroundColor: selected
                ? theme.colorScheme.primary
                : Colors.transparent,

            foregroundColor: selected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Obx(
          () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          actionButton(
            text: "ƒx",
            selected: scientific.isScientific.value,
            onTap: scientific.toggle,
          ),

          actionButton(
            text: "MC",
            onTap: memory.clear,
          ),

          actionButton(
            text: "MR",
            selected: memory.hasMemory,
            onTap: () {
              final value = memory.recall().toString();
              controller.expression.value = value;
              controller.result.value = value;
            },
          ),

          actionButton(
            text: "MS",
            onTap: () {
              memory.store(
                double.tryParse(controller.result.value) ?? 0,
              );
            },
          ),

          actionButton(
            text: "M+",
            onTap: () {
              memory.add(
                double.tryParse(controller.result.value) ?? 0,
              );
            },
          ),

          actionButton(
            text: "M-",
            onTap: () {
              memory.subtract(
                double.tryParse(controller.result.value) ?? 0,
              );
            },
          ),

          const SizedBox(width: 6),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: memory.hasMemory
                ? Container(
              key: ValueKey(memory.memory.value),
              width: 90,
              height: 32,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "M:${memory.memory.value}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}