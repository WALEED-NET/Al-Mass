import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';
// import 'package:gofetch/screens/login/rest_password_view.dart';

class NextToYouCell extends StatelessWidget {
  final Map contentOfONextToYouObject;
  // Function press = (){};
  final VoidCallback onTap;
  NextToYouCell(
      {super.key, required this.contentOfONextToYouObject, required this.onTap
      // required this.press,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                contentOfONextToYouObject["image"].toString(),
                width: 220,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              contentOfONextToYouObject["name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: app_colors.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  contentOfONextToYouObject["type"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: app_colors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                Text(
                  " . ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: app_colors.main,
                    fontSize: 12,
                  ),
                ),
                Text(
                  contentOfONextToYouObject["food_type"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: app_colors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Image.asset(
                  "assets/img/rate.png",
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  contentOfONextToYouObject["rate"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: app_colors.main,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 8,
            //   ),
          ],
        ),
      ),
    );
  }
}
