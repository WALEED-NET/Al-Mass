
import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';

class PopularRestaurantRow extends StatelessWidget {
  final Map contentOfPopularRestaurantObject;
  final VoidCallback onTap;
  const PopularRestaurantRow(
      {super.key,
      required this.contentOfPopularRestaurantObject,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              contentOfPopularRestaurantObject["image"].toString(),
              width: double.maxFinite,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 8,
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contentOfPopularRestaurantObject["name"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: app_colors.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                        contentOfPopularRestaurantObject["rate"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: app_colors.main,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${contentOfPopularRestaurantObject["rating"]} Ratings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: app_colors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        contentOfPopularRestaurantObject["type"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: app_colors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        " . ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: app_colors.main,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        contentOfPopularRestaurantObject["food_type"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: app_colors.secondaryText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
