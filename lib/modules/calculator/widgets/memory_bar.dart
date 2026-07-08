import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/calculator_controller.dart';
import '../controller/memory_controller.dart';

class MemoryBar extends GetView<CalculatorController> {
  const MemoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    final memoryController = Get.find<MemoryController>();
    final theme = Theme.of(context);

    Widget buildButton(String text, VoidCallback onTap) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
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
          () => Card(
        elevation: 0,
        color: theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (memoryController.hasMemory)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    "Memory : ${memoryController.memory.value}",
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              Row(
                children: [
                  buildButton("MC", () {
                    memoryController.clear();
                  }),

                  buildButton("MR", () {
                    controller.onButtonPressed(
                      memoryController.recall().toString(),
                    );
                  }),

                  buildButton("MS", () {
                    memoryController.store(
                      double.tryParse(controller.result.value) ?? 0,
                    );
                  }),

                  buildButton("M+", () {
                    memoryController.add(
                      double.tryParse(controller.result.value) ?? 0,
                    );
                  }),

                  buildButton("M-", () {
                    memoryController.subtract(
                      double.tryParse(controller.result.value) ?? 0,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}