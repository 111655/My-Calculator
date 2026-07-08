import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../app/theme/app_theme.dart';
import '../../../app/theme/app_theme_type.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'app_theme';

  final GetStorage _storage = GetStorage();

  final selectedTheme = AppThemeType.light.obs;

  final currentTheme = AppTheme.lightTheme.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  void loadTheme() {
    final saved = _storage.read(_themeKey);

    if (saved != null) {
      selectedTheme.value = AppThemeType.values.firstWhere(
            (e) => e.name == saved,
        orElse: () => AppThemeType.light,
      );
    }

    _updateTheme();
  }

  void changeTheme(AppThemeType theme) {
    selectedTheme.value = theme;

    _storage.write(_themeKey, theme.name);

    _updateTheme();
  }

  void _updateTheme() {
    switch (selectedTheme.value) {
      case AppThemeType.light:
        currentTheme.value = AppTheme.lightTheme;
        break;

      case AppThemeType.dark:
        currentTheme.value = AppTheme.darkTheme;
        break;

      case AppThemeType.blue:
        currentTheme.value = AppTheme.blueTheme;
        break;

      case AppThemeType.purple:
        currentTheme.value = AppTheme.purpleTheme;
        break;

      case AppThemeType.green:
        currentTheme.value = AppTheme.greenTheme;
        break;

      case AppThemeType.amoled:
        currentTheme.value = AppTheme.amoledTheme;
        break;
    }
  }
}