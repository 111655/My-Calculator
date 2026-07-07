import 'package:flutter/services.dart';

class HapticService {
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  static void selectionClick() {
    HapticFeedback.selectionClick();
  }
}