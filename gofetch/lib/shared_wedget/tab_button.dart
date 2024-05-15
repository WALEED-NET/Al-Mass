import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';

class TapButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;
  final bool isSelected;
  const TapButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.icon,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 15,
            height: 15,
            color: isSelected ? app_colors.main : app_colors.primaryText,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
                color: isSelected ? app_colors.main : app_colors.secondaryText,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
