import 'package:intl/intl.dart';

class NumberFormatter {
  static String format(
      String value, {
        int decimalPlaces = 6,
      }) {
    final number = double.tryParse(value);

    if (number == null) return value;

    final formatter = NumberFormat(
      '#,##0.${'0' * decimalPlaces}',
    );

    String formatted = formatter.format(number);

    while (formatted.contains('.') &&
        (formatted.endsWith('0') ||
            formatted.endsWith('.'))) {
      formatted = formatted.substring(0, formatted.length - 1);
    }

    return formatted;
  }
}