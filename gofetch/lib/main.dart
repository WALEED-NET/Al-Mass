
import 'package:flutter/material.dart';
import 'package:gofetch/screens/login/welcome_view.dart';


void main() {
  runApp((GoFetch()));
}

class GoFetch extends StatelessWidget {
  const GoFetch({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "GoFetch",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Metropolis"
      ),
      home: const WelcomeView(),
    );
  }
}