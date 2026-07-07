import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/theme/app_theme.dart';
import 'modules/calculator/bindings/calculator_binding.dart';
import 'modules/calculator/view/calculator_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  const MyCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calculator',

      initialBinding: CalculatorBinding(),

      home: const CalculatorPage(),

      theme: AppTheme.lightTheme,
    );
  }
}