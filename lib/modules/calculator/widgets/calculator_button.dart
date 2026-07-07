import 'package:flutter/material.dart';

import '../../../app/constants/app_colors.dart';

class CalculatorButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonSize = constraints.maxWidth;

        Color backgroundColor = Colors.white;
        Color textColor = AppColors.textDark;

        if (isOperator) {
          backgroundColor = Colors.deepPurple.shade50;
          textColor = AppColors.primary;
        }

        if (isEqual) {
          backgroundColor = AppColors.primary;
          textColor = Colors.white;
        }

        return Padding(
          padding: const EdgeInsets.all(6),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(buttonSize / 2),
              onTap: onTap,
              child: Ink(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        text,
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
        );
      },
    );
  }
}