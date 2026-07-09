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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settings = Get.find<SettingsController>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final formattedResult = NumberFormatter.format(
      result,
      decimalPlaces: settings.decimalPlaces.value,
    );

    return Container(
      width: double.infinity,
      padding: isLandscape ? const EdgeInsets.only(
        left: 10,right: 10,top: 2,bottom: 0
      ) : const EdgeInsets.only(
          left: 10,right: 10,top: 5,bottom: 5
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                expression.isEmpty ? "0" : expression,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 28,
                  color: theme.colorScheme.onSurface.withOpacity(.6),
                ),
              ),
            ),

            const SizedBox(height: 2),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                formattedResult,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}