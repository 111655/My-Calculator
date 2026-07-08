import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/scientific_button_data.dart';
import '../../settings/controller/scientific_controller.dart';
import '../controller/calculator_controller.dart';
import 'calculator_button.dart';

class ScientificPanel extends GetView<CalculatorController> {
  const ScientificPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scientificController = Get.find<ScientificController>();

    return Obx(
          () => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [

            InkWell(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              onTap: scientificController.toggle,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                child: Row(
                  children: [

                    Icon(
                      Icons.functions,
                      color: theme.colorScheme.primary,
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Text(
                        "Scientific Functions",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    AnimatedRotation(
                      turns: scientificController.isExpanded.value
                          ? .5
                          : 0,
                      duration: const Duration(milliseconds: 250),
                      child: const Icon(Icons.expand_more),
                    ),
                  ],
                ),
              ),
            ),

            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState:
              scientificController.isExpanded.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,

              firstChild: const SizedBox(height: 0),

              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  0,
                  12,
                  12,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemCount: scientificButtons.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (_, index) {
                    final button = scientificButtons[index];

                    return CalculatorButton(
                      text: button.text,
                      isOperator: true,
                      onTap: () =>
                          controller.onButtonPressed(button.text),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}