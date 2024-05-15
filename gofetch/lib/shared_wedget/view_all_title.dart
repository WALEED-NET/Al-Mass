import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';

class ViewAllTitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ViewAllTitleRow({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: app_colors.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            "View all",
            style: TextStyle(
                color: app_colors.main,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
