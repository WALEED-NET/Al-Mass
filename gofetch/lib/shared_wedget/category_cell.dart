import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';

class CategoryCell extends StatelessWidget {
  final Map contentOfObject;
  final VoidCallback onTap;
  const CategoryCell(
      {super.key, required this.contentOfObject, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              // borderRadius: BorderRadius.circular(10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                contentOfObject["image"].toString(),
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              contentOfObject["name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: app_colors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            // const SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}
