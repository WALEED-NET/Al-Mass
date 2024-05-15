import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/main_tabview/main_tab_view.dart';
import 'package:gofetch/shared_wedget/button.dart';

class ThankYouMessageView extends StatefulWidget {
  const ThankYouMessageView({super.key});

  @override
  State<ThankYouMessageView> createState() => _ThankYouMessageViewState();
}

class _ThankYouMessageViewState extends State<ThankYouMessageView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      width: media.width,
      decoration: BoxDecoration(
          color: app_colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: app_colors.primaryText,
                  size: 25,
                ),
              )
            ],
          ),
          Image.asset(
            "assets/img/thank_you.png",
            width: media.width * 0.55,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Thank You!",
            style: TextStyle(
                color: app_colors.primaryText,
                fontSize: 26,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "for your order",
            style: TextStyle(
                color: app_colors.primaryText,
                fontSize: 17,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order",
            textAlign: TextAlign.center,
            style: TextStyle(color: app_colors.primaryText, fontSize: 14),
          ),
          const SizedBox(
            height: 35,
          ),
          Button(title: "Track My Order", onPressed: () {}),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainTabView()));
            },
            child: Text(
              "Back To Home",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: app_colors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
