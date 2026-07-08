import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/services/number_formatter.dart';
import '../../settings/controller/settings_controller.dart';


class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final expressionFont = width > 600 ? 36.0 : 28.0;
    final resultFont = width > 600 ? 58.0 : 44.0;
    final settings = Get.find<SettingsController>();

    final formattedResult = NumberFormatter.format(
      result,
      decimalPlaces: settings.decimalPlaces.value,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2B2D31)
            : Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                expression.isEmpty ? "0" : expression,
                style: TextStyle(
                  fontSize: expressionFont,
                  color: theme.colorScheme.onSurface.withOpacity(0.65),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: GestureDetector(
                onLongPress: () async {
                  await Clipboard.setData(
                    ClipboardData(text: result),
                  );

                  Get.snackbar(
                    "Copied",
                    "Result copied to clipboard",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                },
                child: Text(
                  formattedResult,
                  style: TextStyle(
                    fontSize: resultFont,
                    fontWeight: FontWeight.bold,
                    color:theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}