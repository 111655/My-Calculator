class HistoryModel {
  final String expression;
  final String result;
  final DateTime time;
  final bool isFavorite;
  HistoryModel({
    required this.expression,
    required this.result,
    required this.time,
    this.isFavorite = false,
  });
}