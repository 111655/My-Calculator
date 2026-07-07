import 'dart:math' as math;

import 'package:function_tree/function_tree.dart';
import 'package:get/get.dart';

class CalculatorService {
  /// Evaluate expression
  String evaluate(String expression) {
    if (expression.isEmpty) return "0";

    try {
      String exp = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      final result = exp.interpret();

      return _format(result.toDouble());
    } catch (e) {
      return "Error";
    }
  }

  /// Scientific Operations
  void handleScientific(
      String operation,
      RxString expression,
      RxString result,
      ) {
    double? value = double.tryParse(result.value);

    switch (operation) {
      case "π":
        expression.value += math.pi.toString();
        result.value = expression.value;
        return;

      case "e":
        expression.value += math.e.toString();
        result.value = expression.value;
        return;

      case "√":
        if (value == null || value < 0) {
          result.value = "Error";
          return;
        }

        value = math.sqrt(value);
        break;

      case "x²":
        if (value == null) return;

        value = value * value;
        break;

      case "sin":
        if (value == null) return;

        value = math.sin(value * math.pi / 180);
        break;

      case "cos":
        if (value == null) return;

        value = math.cos(value * math.pi / 180);
        break;

      case "tan":
        if (value == null) return;

        value = math.tan(value * math.pi / 180);
        break;

      case "log":
        if (value == null || value <= 0) {
          result.value = "Error";
          return;
        }

        value = math.log(value) / math.ln10;
        break;

      case "ln":
        if (value == null || value <= 0) {
          result.value = "Error";
          return;
        }

        value = math.log(value);
        break;

      default:
        return;
    }

    expression.value = _format(value);
    result.value = expression.value;
  }

  /// Format Result
  String _format(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }

    return value.toStringAsPrecision(12);
  }
}