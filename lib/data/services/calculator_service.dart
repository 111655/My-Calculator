import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  String evaluate(String expression) {
    if (expression.trim().isEmpty) {
      return "0";
    }

    try {
      expression = expression
          .replaceAll("×", "*")
          .replaceAll("÷", "/");

      Parser parser = Parser();

      Expression exp = parser.parse(expression);

      ContextModel cm = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, cm);

      if (result == result.toInt()) {
        return result.toInt().toString();
      }

      return result.toString();
    } catch (_) {
      return "Error";
    }
  }
}