import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/history_controller.dart';
import '../widgets/history_statistics.dart';

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
          IconButton(
            tooltip: "Export",
            icon: const Icon(Icons.file_upload_outlined),
            onPressed: () {
              controller.exportHistory();
            },
          ),
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

      return Column(
        children: [
          /// Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search history...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.searchQuery.value = "";
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
            ),
          ),
          const HistoryStatistics(),
          /// History List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: controller.filteredHistory.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, index) {
                final item = controller.filteredHistory[index];

                return Dismissible(
                  key: ValueKey(item.time.toIso8601String()),
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
                      size: 30,
                    ),
                  ),

                  confirmDismiss: (_) async {
                    return await Get.dialog<bool>(
                      AlertDialog(
                        title: const Text("Delete Calculation"),
                        content: const Text(
                          "Do you want to remove this calculation from history?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(result: false),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () => Get.back(result: true),
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  },

                  onDismissed: (_) {
                    controller.deleteHistory(index);
                  },

                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        controller.useCalculation2(item);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor:
                              theme.colorScheme.primary.withOpacity(.12),
                              child: Icon(
                                Icons.calculate_rounded,
                                color: theme.colorScheme.primary,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.expression,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    "= ${item.result}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    "${item.time.day}/${item.time.month}/${item.time.year} • "
                                        "${item.time.hour.toString().padLeft(2, '0')}:"
                                        "${item.time.minute.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            IconButton(
                              icon: Icon(
                                item.isFavorite
                                    ? Icons.star
                                    : Icons.star_border,
                                color: item.isFavorite
                                    ? Colors.amber
                                    : null,
                              ),
                              tooltip: "Favorite",
                              onPressed: () {
                                controller.toggleFavorite(item);
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.copy_rounded),
                              tooltip: "Copy Result",
                              onPressed: () {
                                controller.copyResult(item.result);
                              },
                            ),
                          ],
                        ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }),
    );
  }
}