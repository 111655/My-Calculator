class HistoryModel {
  final dynamic hiveKey;
  final String expression;
  final String result;
  final DateTime time;
  final bool isFavorite;

  HistoryModel({
    required this.hiveKey,
    required this.expression,
    required this.result,
    required this.time,
    this.isFavorite = false,
  });
}