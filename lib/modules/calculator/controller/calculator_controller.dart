import 'package:get/get.dart';
import '../../../core/services/calculator_service.dart';
import '../../history/controller/history_controller.dart';

class CalculatorController extends GetxController {
  final CalculatorService _service = CalculatorService();
  final HistoryController historyController = Get.find<HistoryController>();

  final RxString expression = ''.obs;
  final RxString result = '0'.obs;
  final RxDouble memoryValue = 0.0.obs;

  static const List<String> _operators = ['+', '-', '×', '÷'];

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
      case 'MC':
        memoryClear();
        break;

      case 'MR':
        memoryRecall();
        break;

      case 'M+':
        memoryAdd();
        break;

      case 'M-':
        memorySubtract();
        break;

    // Scientific Functions
      case 'π':
      case 'e':
      case '√':
      case 'x²':
      case 'xʸ':
      case 'sin':
      case 'cos':
      case 'tan':
      case 'log':
      case 'ln':
        _service.handleScientific(
          value,
          expression,
          result,
        );
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

    final last = expression.value[expression.value.length - 1];

    if (_operators.contains(last)) {
      expression.value =
          expression.value.substring(0, expression.value.length - 1) + op;
    } else {
      expression.value += op;
    }
  }

  //================ LIVE RESULT ===================

  void _liveCalculate() {
    final value = _service.evaluate(expression.value);

    if (value != "Error") {
      result.value = value;
    }
  }

  //================ CALCULATE ===================

  void calculate() {
    final value = _service.evaluate(expression.value);

    result.value = value;

    if (value != "Error") {
      historyController.addHistory(
        expression.value,
        value,
      );

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
      result.value = '0';
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
  void memoryClear() {
    memoryValue.value = 0;
  }

  void memoryRecall() {
    expression.value = memoryValue.value.toString();
    result.value = expression.value;
  }

  void memoryAdd() {
    final value = double.tryParse(result.value);
    if (value != null) {
      memoryValue.value += value;
    }
  }

  void memorySubtract() {
    final value = double.tryParse(result.value);
    if (value != null) {
      memoryValue.value -= value;
    }
  }

  //================ DECIMAL ===================

  bool _currentNumberContainsDecimal() {
    final text = expression.value;

    final index = text.lastIndexOf(RegExp(r'[+\-×÷]'));

    final number = index == -1 ? text : text.substring(index + 1);

    return number.contains('.');
  }
}