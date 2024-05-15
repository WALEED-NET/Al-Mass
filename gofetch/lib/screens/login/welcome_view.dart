import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/screens/login/login_view.dart';
import 'package:gofetch/screens/login/sing_up_view.dart';
import 'package:gofetch/shared_wedget/button.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(children: [
      Container(
        height: media.height * 0.66,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              "assets/img/welcome_top_shape.png",
              width: media.width,
              fit: BoxFit.cover,
            ),
            Icon(
              Icons.question_mark,
              weight: 200,
              size: 200,
              color: app_colors.main,
            )
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Who has ",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: app_colors.main,
            ),
          ),
          const Text(
            "it",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Now you can ave your customer inovices \nno need to write it handly",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: app_colors.secondaryText,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Button(
            title: "Login",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
          )),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Button(
            type: ButtonType.textPrimary,
            title: "Create An Account",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SingUpView()));
            },
          )),
    ]));
  }
}
