import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/theme/app_theme.dart';
import 'modules/calculator/bindings/calculator_binding.dart';
import 'modules/calculator/view/calculator_page.dart';
import 'modules/history/controller/history_controller.dart';
import 'modules/settings/bindings/settings_binding.dart';
import 'modules/settings/controller/settings_controller.dart';
import 'modules/settings/controller/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  SettingsBinding().dependencies();
  await GetStorage.init();
  // Get.put(SettingsController(), permanent: true);
  // Get.put(ThemeController(), permanent: true);
  // Get.put(HistoryController(), permanent: true);
  await Hive.openBox('calculator_history');

  runApp(const MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  const MyCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calculator',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: CalculatorBinding(),
      home: const CalculatorPage(),
    );
  }
}