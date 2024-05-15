import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';

enum ButtonType { bgPrimary, textPrimary }

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final ButtonType type;
  final double fontSize;
  const Button(
      {super.key,
      required this.title,
      required this.onPressed,
      this.fontSize = 16,
      this.type = ButtonType.bgPrimary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: type == ButtonType.bgPrimary
              ? null
              : Border.all(color: app_colors.main, width: 1),
          color:
              type == ButtonType.bgPrimary ? app_colors.main : app_colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: type == ButtonType.bgPrimary
                  ? app_colors.white
                  : app_colors.main,
              fontSize: fontSize,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
