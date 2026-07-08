import 'package:get/get.dart';

class ScientificController extends GetxController {
  /// Scientific mode state
  final RxBool _isScientific = false.obs;

  /// Getter
  bool get isEnabled => _isScientific.value;

  /// Observable
  RxBool get isScientific => _isScientific;

  //================ TOGGLE =================

  void toggle() {
    _isScientific.value = !_isScientific.value;
  }

  //================ SET =================

  void setScientific(bool value) {
    if (_isScientific.value == value) return;
    _isScientific.value = value;
  }

  //================ ENABLE =================

  void enable() => setScientific(true);

  //================ DISABLE =================

  void disable() => setScientific(false);
}