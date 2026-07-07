import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool isOperator;
  final bool isEqual;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isOperator = false,
    this.isEqual = false,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _pressed = false;

  Future<void> _handleTap() async {
    HapticFeedback.selectionClick();

    setState(() {
      _pressed = true;
    });

    await Future.delayed(const Duration(milliseconds: 80));

    if (mounted) {
      setState(() {
        _pressed = false;
      });
    }

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonSize = constraints.maxWidth;

        Color backgroundColor;
        Color textColor;

        if (widget.isEqual) {
          backgroundColor = theme.colorScheme.primary;
          textColor = Colors.white;
        } else if (widget.isOperator) {
          backgroundColor = isDark
              ? const Color(0xFF383B40)
              : const Color(0xFFEDE7F6);

          textColor = theme.colorScheme.primary;
        } else {
          backgroundColor =
          isDark ? const Color(0xFF2B2D31) : Colors.white;

          textColor = isDark ? Colors.white : Colors.black87;
        }

        return Padding(
          padding: const EdgeInsets.all(2),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 80),
            curve: Curves.easeOut,
            scale: _pressed ? 0.92 : 1,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(22),
              child: InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: _handleTap,
                splashColor:
                theme.colorScheme.primary.withOpacity(.15),
                highlightColor: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                    ],
                  ),
                  child: SizedBox.expand(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: buttonSize * .28,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}