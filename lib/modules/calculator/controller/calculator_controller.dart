import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:my_calculator/data/services/calculatorService.dart';
import '../../history/controller/history_controller.dart';

class CalculatorController extends GetxController {
  final CalculatorService _service = CalculatorService();
  final HistoryController historyController =
  Get.find<HistoryController>();

  final RxString expression = ''.obs;
  final RxString result = '0'.obs;
  final RxString lastExpression = ''.obs;

  static const List<String> _operators = [
    '+',
    '-',
    '×',
    '÷',
  ];

  //================ BUTTON PRESS =================

  void onButtonPressed(String value) {
    switch (value) {
      case 'AC':
        clear();
        break;

      case '⌫':
        backspace();
        break;

      case '=':
        if (canCalculate()) {
          calculate();
        }
        break;

      case '+/-':
        toggleSign();
        break;

      case '%':
        percentage();
        break;

      case '(':
      case ')':
        handleParentheses();
        break;

    // Scientific Constants
      case 'π':
      case 'e':
        append(_service.constant(value));
        break;

    // Scientific Functions
      case '√':
      case 'x²':
      case '1/x':
      case 'sin':
      case 'cos':
      case 'tan':
      case 'log':
      case 'ln':
      case '!':
        result.value =
            _service.scientific(value, result.value);
        expression.value = result.value;
        break;

      case 'xʸ':
        append("^");
        break;

      default:
        append(value);
    }
  }

  //================ APPEND =================

  void append(String value) {
    if (expression.value == result.value &&
        lastExpression.value.isNotEmpty) {
      lastExpression.value = '';
    }

    if (_operators.contains(value)) {
      _handleOperator(value);
      return;
    }

    if (value == "." &&
        _currentNumberContainsDecimal()) {
      return;
    }

    expression.value += value;

    _liveCalculate();
  }

  //================ OPERATOR =================

  void _handleOperator(String op) {
    if (expression.value.isEmpty) {
      if (op == "-") {
        expression.value = "-";
      }
      return;
    }

    final last = expression.value.characters.last;

    if (_operators.contains(last)) {
      expression.value =
          expression.value.substring(
            0,
            expression.value.length - 1,
          );

      expression.value += op;
      return;
    }

    if (last == "(" && op != "-") {
      return;
    }

    expression.value += op;
  }

  //================ LIVE RESULT =================

  void _liveCalculate() {
    final value =
    _service.evaluate(expression.value);

    if (value != "Error") {
      result.value = value;
    }
  }

  //================ VALIDATE =================

  bool canCalculate() {
    if (expression.value.isEmpty) return false;

    final last =
        expression.value.characters.last;

    if (_operators.contains(last)) {
      return false;
    }

    if (last == "(") {
      return false;
    }

    return true;
  }

  //================ CALCULATE =================

  void calculate() {
    while ('('
        .allMatches(expression.value)
        .length >
        ')'
            .allMatches(expression.value)
            .length) {
      expression.value += ")";
    }

    final value =
    _service.evaluate(expression.value);

    result.value = value;

    if (value != "Error") {
      lastExpression.value = expression.value;

      historyController.addHistory(
        expression.value,
        value,
      );

      result.value = value;
      expression.value = value;
    }
  }

  //================ CLEAR =================

  void clear() {
    expression.value = '';
    result.value = '0';
    lastExpression.value = '';
  }

  //================ BACKSPACE =================

  void backspace() {
    if (expression.value.isEmpty) return;

    if (expression.value.endsWith("×(")) {
      expression.value =
          expression.value.substring(
            0,
            expression.value.length - 2,
          );
    } else {
      expression.value =
          expression.value.substring(
            0,
            expression.value.length - 1,
          );
    }

    if (expression.value.isEmpty) {
      result.value = "0";
      return;
    }

    _liveCalculate();
  }

  //================ PERCENT =================

  void percentage() {
    if (expression.value.isEmpty) return;

    expression.value =
    "(${expression.value})/100";

    _liveCalculate();
  }

  //================ SIGN =================

  void toggleSign() {
    if (expression.value.isEmpty) return;

    if (expression.value.startsWith("-")) {
      expression.value =
          expression.value.substring(1);
    } else {
      expression.value =
      "-${expression.value}";
    }

    _liveCalculate();
  }

  //================ DECIMAL =================

  bool _currentNumberContainsDecimal() {
    final text = expression.value;

    final index = text.lastIndexOf(
      RegExp(r'[+\-×÷]'),
    );

    final number = index == -1
        ? text
        : text.substring(index + 1);

    return number.contains(".");
  }

  //================ SHARE =================

  void shareCalculation() {
    if (expression.value.isEmpty) return;

    String text;

    if (lastExpression.value.isNotEmpty &&
        expression.value == result.value) {
      // After pressing =
      text = "${lastExpression.value} = ${result.value}";
    } else {
      // User is still typing
      text = expression.value;
    }

    Share.share(
      text,
      subject: "Calculator Result",
    );
  }

  //================ SMART PARENTHESES =================

  void handleParentheses() {
    final text = expression.value;

    final open =
        '('.allMatches(text).length;

    final close =
        ')'.allMatches(text).length;

    if (text.isEmpty) {
      append("(");
      return;
    }

    final last =
        text.characters.last;

    if (_operators.contains(last) ||
        last == "(") {
      append("(");
      return;
    }

    if (open > close) {
      append(")");
      return;
    }

    append("×(");
  }
}