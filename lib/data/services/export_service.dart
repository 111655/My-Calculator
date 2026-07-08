import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'models/history_model.dart';

class ExportService {
  static Future<void> exportHistory(
      List<HistoryModel> history,
      ) async {
    final directory = await getTemporaryDirectory();

    final file = File(
      '${directory.path}/calculator_history.txt',
    );

    final buffer = StringBuffer();

    buffer.writeln("Calculator History");
    buffer.writeln(
        "==============================");
    buffer.writeln();

    for (final item in history) {
      buffer.writeln(item.expression);
      buffer.writeln("= ${item.result}");
      buffer.writeln(item.time);
      buffer.writeln("----------------------");
    }

    await file.writeAsString(buffer.toString());

    await Share.shareXFiles(
      [XFile(file.path)],
      text: "My Calculator History",
    );
  }
}