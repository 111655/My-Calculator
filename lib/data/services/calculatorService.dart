import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  final Parser _parser = Parser();

  //================ EVALUATE =================

  String evaluate(String expression) {
    if (expression.trim().isEmpty) {
      return "0";
    }

    try {
      final exp = _prepareExpression(expression);

      final parsed = _parser.parse(exp);

      final result = parsed.evaluate(
        EvaluationType.REAL,
        ContextModel(),
      );

      if (result.isNaN || result.isInfinite) {
        return "Error";
      }

      return format(result);
    } catch (_) {
      return "Error";
    }
  }

  //================ PREPARE =================

  String _prepareExpression(String exp) {
    exp = exp
        .replaceAll("×", "*")
        .replaceAll("÷", "/")
        .replaceAll("%", "/100")
        .replaceAll("xʸ", "^")
        .replaceAll("x²", "^2");

    // Constants
    exp = exp
        .replaceAll("π", math.pi.toString())
        .replaceAll("e", math.e.toString());

    // Square root
    exp = exp.replaceAll("√", "sqrt");

    //--------------- Implicit Multiplication ----------------//

    // 2(3+4) -> 2*(3+4)
    exp = exp.replaceAllMapped(
      RegExp(r'(\d)\('),
          (m) => '${m.group(1)}*(',
    );

    // (2+3)4 -> (2+3)*4
    exp = exp.replaceAllMapped(
      RegExp(r'\)(\d)'),
          (m) => ')*${m.group(1)}',
    );

    // (2+3)(4+5) -> (2+3)*(4+5)
    exp = exp.replaceAll(")(", ")*(");

    // 2sqrt(9) -> 2*sqrt(9)
    exp = exp.replaceAllMapped(
      RegExp(r'(\d)sqrt'),
          (m) => '${m.group(1)}*sqrt',
    );

    // 2pi
    exp = exp.replaceAllMapped(
      RegExp(r'(\d)${math.pi.toString()}'),
          (m) => '${m.group(1)}*${math.pi}',
    );

    return exp;
  }

  //================ FORMAT =================

  String format(double value) {
    if (value.isNaN || value.isInfinite) {
      return "Error";
    }

    if (value == value.toInt()) {
      return value.toInt().toString();
    }

    return value
        .toStringAsFixed(10)
        .replaceFirst(RegExp(r'\.?0+$'), '');
  }

  //================ SCIENTIFIC =================

  String scientific(String operation, String current) {
    final value = double.tryParse(current);

    if (value == null) return "Error";

    try {
      switch (operation) {
        case "√":
          if (value < 0) return "Error";
          return format(math.sqrt(value));

        case "x²":
          return format(value * value);

        case "1/x":
          if (value == 0) return "Error";
          return format(1 / value);

        case "sin":
          return format(math.sin(value * math.pi / 180));

        case "cos":
          return format(math.cos(value * math.pi / 180));

        case "tan":
          return format(math.tan(value * math.pi / 180));

        case "log":
          if (value <= 0) return "Error";
          return format(math.log(value) / math.ln10);

        case "ln":
          if (value <= 0) return "Error";
          return format(math.log(value));

        case "!":
          return format(_factorial(value));

        default:
          return current;
      }
    } catch (_) {
      return "Error";
    }
  }

  //================ CONSTANTS =================

  String constant(String constant) {
    switch (constant) {
      case "π":
        return format(math.pi);

      case "e":
        return format(math.e);

      default:
        return constant;
    }
  }

  //================ FACTORIAL =================

  double _factorial(double value) {
    if (value < 0 || value != value.floor()) {
      throw Exception("Invalid factorial");
    }

    double result = 1;

    for (int i = 2; i <= value; i++) {
      result *= i;
    }

    return result;
  }
}