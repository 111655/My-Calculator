import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/history_controller.dart';

class HistoryStatistics extends GetView<HistoryController> {
  const HistoryStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buildItem(
        IconData icon,
        String title,
        int value,
        Color color,
        ) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(.7),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Obx(
          () => Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        child: Row(
          children: [

            buildItem(
              Icons.calculate,
              "Total",
              controller.totalCalculations,
              Colors.blue,
            ),

            const SizedBox(width: 10),

            buildItem(
              Icons.star,
              "Favorites",
              controller.favoriteCalculations,
              Colors.amber,
            ),

            const SizedBox(width: 10),

            buildItem(
              Icons.today,
              "Today",
              controller.todayCalculations,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}