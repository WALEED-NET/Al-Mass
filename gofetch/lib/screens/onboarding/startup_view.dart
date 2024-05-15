import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/screens/login/welcome_view.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  //1
  void welcomePage(){
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WelcomeView()));
    }
  //2
    void goWelcomePage() async{
      await Future.delayed(const Duration(seconds: 3));
      welcomePage();
    }
  //3
    void initState(){
      super.initState();
      goWelcomePage();
    }
  
  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/img/splash_bg.png",
                width: media.width,
                height: media.height,
                fit: BoxFit.cover,
                ),
              Image.asset(
                "assets/img/logo.png",
                width: media.width * 0.75,
                height: media.height * 0.75,
                fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: 250,
                  child: Row(
                    children: [
                      Text(
                                "who has  ",
                                style: TextStyle(
                                  color: app_colors.main,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 50
                                ),
                                ),
                      const Text(
                                "it",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                  fontSize: 44
                                ),
                                ),
                    ],
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

}