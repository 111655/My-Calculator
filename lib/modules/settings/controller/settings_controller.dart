import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final GetStorage _storage = GetStorage();

  // Keys
  static const String _themeKey = 'dark_mode';
  static const String _hapticKey = 'haptic';
  static const String _soundKey = 'sound';
  static const String _decimalKey = 'decimal';

  // Observable Values
  final RxBool isDarkMode = false.obs;
  final RxBool hapticEnabled = true.obs;
  final RxBool soundEnabled = false.obs;
  final RxInt decimalPlaces = 6.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  //================ LOAD SETTINGS =================

  void loadSettings() {
    isDarkMode.value = _storage.read(_themeKey) ?? false;
    hapticEnabled.value = _storage.read(_hapticKey) ?? true;
    soundEnabled.value = _storage.read(_soundKey) ?? false;
    decimalPlaces.value = _storage.read(_decimalKey) ?? 6;
  }

  //================ THEME =================

  void setTheme(bool value) {
    isDarkMode.value = value;
    _storage.write(_themeKey, value);
  }

  //================ HAPTIC =================

  void toggleHaptic(bool value) {
    hapticEnabled.value = value;
    _storage.write(_hapticKey, value);

    debugPrint("Haptic Changed: $value");
  }

  //================ SOUND =================

  void toggleSound(bool value) {
    soundEnabled.value = value;
    _storage.write(_soundKey, value);
  }

  //================ DECIMAL =================

  void setDecimal(int value) {
    decimalPlaces.value = value;
    _storage.write(_decimalKey, value);
  }

  //================ RESET =================

  void resetSettings() {
    isDarkMode.value = false;
    hapticEnabled.value = true;
    soundEnabled.value = false;
    decimalPlaces.value = 6;

    _storage.write(_themeKey, false);
    _storage.write(_hapticKey, true);
    _storage.write(_soundKey, false);
    _storage.write(_decimalKey, 6);
  }
}