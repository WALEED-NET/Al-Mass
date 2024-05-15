import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/screens/login/sing_up_view.dart';
import 'package:gofetch/shared_wedget/button.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';
import '../../api/api_crud.dart';
import '../../api/api_strings.dart';
import '../../main_tabview/main_tab_view.dart';

class LoginView extends StatefulWidget {
   LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController textEmail = TextEditingController();
    TextEditingController textPassword = TextEditingController();

  // crud instant
  final crud _crud = crud();

// endpoint login logic
  login() async {
    var response = await _crud.postRequest(loginApi, {
      "user_email": textEmail.text,
      "user_password": textPassword.text
    });
    // print(response);
    if (response["status"] == "success") {

      // Navigator.pushAndRemoveUntil(
      //     context, MaterialPageRoute(builder: (context) => MainTabView()));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>  MainTabView()),
        ((route) => false),
      );
      

      // print(response);

      // globalUserId = response["data"][0]["user_id"];
      // globalUserName = response["data"][0]["user_username"];
    } 
    else {
      print("faield");
      // print(response);
    }
  }


  @override
  Widget build(BuildContext context) {
    
    // String errorLogin = " ";

    // void media = MediaQuery.of(context).size;

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const SizedBox(
                  height: 64,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: app_colors.primaryText,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Add your details to login",
                  style: TextStyle(
                    color: app_colors.secondaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                roundtext(
                  bgColor: app_colors.placeholder,
                  hintText: "Your Email",
                  controller: textEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                ),
                const SizedBox(
                  height: 20,
                ),
                roundtext(
                  bgColor: app_colors.placeholder,
                  hintText: "Password",
                  controller: textPassword,
                  obscureText: true,
                  validator: passwordValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                Button(
                  title: "Login",
                  fontSize: 18,
                  onPressed: () async {
                   if (emailValidator(textEmail.text) == null &&
                       passwordValidator(textPassword.text) == null
                   ) {
                     await login();

                      //  Navigator.push(context,
                      // MaterialPageRoute(builder: (context) => MainTabView()));
                   }  
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
               
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SingUpView()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an Account? ",
                        style: TextStyle(
                          color: app_colors.secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Sing Up",
                        style: TextStyle(
                          color: app_colors.main,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ));
  }


  // validator methods

  String? emailValidator(String email) {
    final RegExp emailPattern =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,}$');

    if (!emailPattern.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? passwordValidator(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

}



