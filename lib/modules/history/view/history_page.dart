import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/history_controller.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculation History"),
        centerTitle: true,
        actions: [
          Obx(() {
            if (controller.history.isEmpty) {
              return const SizedBox();
            }

            return IconButton(
              icon: const Icon(Icons.delete_sweep_rounded),
              tooltip: "Clear History",
              onPressed: () {
                Get.defaultDialog(
                  title: "Clear History",
                  middleText:
                  "Are you sure you want to delete all calculations?",
                  textCancel: "Cancel",
                  textConfirm: "Delete",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    controller.clearHistory();
                    Get.back();
                  },
                );
              },
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.history.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history_rounded,
                  size: 90,
                  color: theme.colorScheme.primary.withOpacity(.5),
                ),
                const SizedBox(height: 20),
                const Text(
                  "No calculations yet",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Your calculation history will appear here.",
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(.6),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.history.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, index) {
            final item = controller.history[index];

            return Dismissible(
              key: ValueKey(
                "${item.expression}-${item.result}-$index",
              ),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (_) {
                controller.deleteHistory(index);

                Get.snackbar(
                  "Deleted",
                  "Calculation removed",
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    backgroundColor:
                    theme.colorScheme.primary.withOpacity(.12),
                    child: Icon(
                      Icons.calculate_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    item.expression,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "= ${item.result}",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.copy_rounded),
                    tooltip: "Copy Result",
                    onPressed: () {
                      controller.copyResult(item.result);
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}