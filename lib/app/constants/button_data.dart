import '../../modules/calculator/model/button_model.dart';

const buttons = [

  ButtonModel(text: "AC", isOperator: true),
  ButtonModel(text: "()", isOperator: true),
  ButtonModel(text: "%", isOperator: true),
  ButtonModel(text: "÷", isOperator: true),

  ButtonModel(text: "7"),
  ButtonModel(text: "8"),
  ButtonModel(text: "9"),
  ButtonModel(text: "×", isOperator: true),

  ButtonModel(text: "4"),
  ButtonModel(text: "5"),
  ButtonModel(text: "6"),
  ButtonModel(text: "-", isOperator: true),

  ButtonModel(text: "1"),
  ButtonModel(text: "2"),
  ButtonModel(text: "3"),
  ButtonModel(text: "+", isOperator: true),

  ButtonModel(text: "+/-"),
  ButtonModel(text: "0"),
  ButtonModel(text: "."),
  ButtonModel(text: "=", isOperator: true),
];