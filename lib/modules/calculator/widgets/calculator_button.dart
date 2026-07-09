import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import '../../../data/services/audio_service.dart';
import '../../settings/controller/settings_controller.dart';

class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool isOperator;
  final bool isEqual;
  final double? fontSize;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isOperator = false,
    this.isEqual = false,
    this.fontSize,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _pressed = false;

  late final SettingsController settingsController;

  @override
  void initState() {
    super.initState();
    settingsController = Get.find<SettingsController>();
  }

  Future<void> _handleTap() async {
    //debugPrint("Button: ${widget.text}");

    // Haptic
    if (settingsController.hapticEnabled.value) {
      try {
        final hasVibrator = await Vibration.hasVibrator();

        debugPrint("Has Vibrator: $hasVibrator");

        if (hasVibrator == true) {
          await Vibration.vibrate(
            duration: 50,
          );
        }
      } catch (e) {
        debugPrint("Vibration Error: $e");
      }
    }

    // Sound
    if (settingsController.soundEnabled.value) {
      try {
        await AudioService.instance.playClick();
      } catch (e) {
        debugPrint("Sound Error: $e");
      }
    }

    setState(() => _pressed = true);

    await Future.delayed(const Duration(milliseconds: 80));

    if (mounted) {
      setState(() => _pressed = false);
    }

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color backgroundColor;
    final Color textColor;

    if (widget.isEqual) {
      backgroundColor = theme.colorScheme.primary;
      textColor = Colors.white;
    } else if (widget.isOperator) {
      backgroundColor = isDark
          ? const Color(0xFF3A3D42)
          : const Color(0xFFE8EAF6);

      textColor = theme.colorScheme.primary;
    } else {
      backgroundColor =
      isDark ? const Color(0xFF2C2C2C) : Colors.white;

      textColor = isDark ? Colors.white : Colors.black87;
    }

    return AnimatedScale(
      scale: _pressed ? 0.92 : 1,
      duration: const Duration(milliseconds: 100),
      child: Material(
        color: backgroundColor,
        elevation: isDark ? 0 : 3,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          splashColor: theme.colorScheme.primary.withOpacity(.15),
          onTap: _handleTap,
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}