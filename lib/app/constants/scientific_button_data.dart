import '../../modules/calculator/model/button_model.dart';

final List<ButtonModel> scientificButtons = [
  // Row 1
  ButtonModel(text: "sin", isOperator: true),
  ButtonModel(text: "cos", isOperator: true),
  ButtonModel(text: "tan", isOperator: true),
  ButtonModel(text: "√", isOperator: true),

  // Row 2
  ButtonModel(text: "log", isOperator: true),
  ButtonModel(text: "ln", isOperator: true),
  ButtonModel(text: "π", isOperator: true),
  ButtonModel(text: "e", isOperator: true),

  // Row 3
  ButtonModel(text: "x²", isOperator: true),
  ButtonModel(text: "xʸ", isOperator: true),
  ButtonModel(text: "1/x", isOperator: true),
  ButtonModel(text: "!", isOperator: true),

  // Row 4
  ButtonModel(text: "(", isOperator: true),
  ButtonModel(text: ")", isOperator: true),
];