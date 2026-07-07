import 'package:get/get.dart';

import '../../../data/services/calculator_service.dart';

class CalculatorController extends GetxController {
  final CalculatorService _service = CalculatorService();

  final RxString expression = ''.obs;
  final RxString result = '0'.obs;

  final List<String> _operators = ['+', '-', '×', '÷'];

  void onButtonPressed(String value) {
    switch (value) {
      case 'AC':
        clear();
        break;

      case '⌫':
        backspace();
        break;

      case '=':
        calculate();
        break;

      case '+/-':
        toggleSign();
        break;

      case '%':
        percentage();
        break;

      default:
        append(value);
    }
  }

  //================ APPEND ===================

  void append(String value) {
    if (_operators.contains(value)) {
      _handleOperator(value);
      return;
    }

    if (value == '.') {
      if (_currentNumberContainsDecimal()) return;
    }

    expression.value += value;
    _liveCalculate();
  }

  //================ OPERATOR ===================

  void _handleOperator(String op) {
    if (expression.value.isEmpty) {
      if (op == '-') {
        expression.value = '-';
      }
      return;
    }

    String last = expression.value[expression.value.length - 1];

    if (_operators.contains(last)) {
      expression.value =
          expression.value.substring(0, expression.value.length - 1) + op;
    } else {
      expression.value += op;
    }
  }

  //================ LIVE RESULT ===================

  void _liveCalculate() {
    String value = _service.evaluate(expression.value);

    if (value != "Error") {
      result.value = value;
    }
  }

  //================ CALCULATE ===================

  void calculate() {
    String value = _service.evaluate(expression.value);

    result.value = value;

    if (value != "Error") {
      expression.value = value;
    }
  }

  //================ CLEAR ===================

  void clear() {
    expression.value = '';
    result.value = '0';
  }

  //================ BACKSPACE ===================

  void backspace() {
    if (expression.value.isEmpty) return;

    expression.value =
        expression.value.substring(0, expression.value.length - 1);

    if (expression.value.isEmpty) {
      result.value = "0";
      return;
    }

    _liveCalculate();
  }

  //================ PERCENT ===================

  void percentage() {
    if (expression.value.isEmpty) return;

    expression.value = "(${expression.value})/100";

    _liveCalculate();
  }

  //================ SIGN ===================

  void toggleSign() {
    if (expression.value.isEmpty) return;

    if (expression.value.startsWith('-')) {
      expression.value = expression.value.substring(1);
    } else {
      expression.value = '-${expression.value}';
    }

    _liveCalculate();
  }

  //================ DECIMAL CHECK ===================

  bool _currentNumberContainsDecimal() {
    String text = expression.value;

    int index = text.lastIndexOf(RegExp(r'[+\-×÷]'));

    String number = index == -1 ? text : text.substring(index + 1);

    return number.contains('.');
  }
}