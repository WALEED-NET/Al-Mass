import 'package:flutter/material.dart';
import 'package:gofetch/api/api_crud.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/shared_wedget/button.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';

import '../../api/api_strings.dart';
import 'login_view.dart';

class SingUpView extends StatefulWidget {
  const SingUpView({super.key, });

  @override
  State<SingUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends State<SingUpView> {

    TextEditingController textName = TextEditingController();
    TextEditingController textEmail = TextEditingController();
    TextEditingController textMobileNumber = TextEditingController();
    TextEditingController textAddress = TextEditingController();
    TextEditingController textPassword = TextEditingController();
    TextEditingController textConfirmPassword = TextEditingController();

crud _crud = crud();


// signup logic

signup() async {
    var response = await _crud.postRequest(signupApi, {
      "user_username": textName.text,
      "user_email": textEmail.text,
      "user_password": textPassword.text
    });
    if (response["status"] == 'success') {

      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
       Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginView()));
    } 
    else {
      print("Sing up Failed");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 64,
              ),
              Text(
                "Sing Up",
                style: TextStyle(
                    color: app_colors.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Add your details to sing up",
                style: TextStyle(
                  color: app_colors.secondaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              roundtext(
                bgColor: app_colors.placeholder,
                left: Icon(Icons.person, color: app_colors.textFiled),
                hintText: "Name",
                controller: textName,
                validator: nameValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              roundtext(
                bgColor: app_colors.placeholder,
                left: Icon(Icons.email, color: app_colors.textFiled),
                hintText: "Email",
                controller: textEmail,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              roundtext(
                bgColor: app_colors.placeholder,
                left: Icon(Icons.phone, color: app_colors.textFiled),
                hintText: "Mobile No",
                controller: textMobileNumber,
                keyboardType: TextInputType.number,
                validator: mobileNumberValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              roundtext(
                bgColor: app_colors.placeholder,
                left: Icon(Icons.location_city, color: app_colors.textFiled),
                hintText: "Address",
                controller: textAddress,
                validator: addressValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              roundtext(
                left: Icon(
                  Icons.lock,
                  color: app_colors.textFiled,
                ),
                bgColor: app_colors.placeholder,
                hintText: "Password",
                controller: textPassword,
                obscureText: true,
                validator: passwordValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              roundtext(
                bgColor: app_colors.placeholder,
                left: Icon(Icons.lock, color: app_colors.textFiled),
                hintText: "Confirm Password",
                controller: textConfirmPassword,
                obscureText: true,
                validator: confirmPasswordValidator,
              ),
              const SizedBox(
                height: 25,
              ),
              Button(
                title: "Sing Up",
                onPressed: () async {

                  if (nameValidator(textName.text) == null &&
                      emailValidator(textEmail.text) == null &&
                      passwordValidator(textPassword.text)== null 
                  ) {
                    await signup();
                     
                  }
                },
              ),
              const SizedBox(
                height: 4,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account? ",
                      style: TextStyle(
                        color: app_colors.secondaryText,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: app_colors.main,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // vaidator methods

  String? nameValidator(String name) {
  if (name.isEmpty) {
    return 'Name cannot be empty';
  }
  // You can add further validation for name format (e.g., no special characters)
  // based on your specific requirements.
  return null;
}

String? emailValidator(String email) {
    final RegExp emailPattern =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,}$');

    if (!emailPattern.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

String? mobileNumberValidator(String mobileNumber) {
  final RegExp phonePattern = RegExp(r'^[0-9+]{6,15}$'); // Adjust pattern based on region
  if (!phonePattern.hasMatch(mobileNumber)) {
    return 'Invalid mobile number format';
  }
  return null;
}

String? addressValidator(String address) {
  if (address.isEmpty) {
    return 'Address cannot be empty';
  }
  // You can add further validation for address format (e.g., minimum characters)
  // but consider allowing flexibility for various address structures.
  return null;
}

String? passwordValidator(String password) {
  if (password.isEmpty) {
    return 'Password cannot be empty';
  }
  // Add validation for password strength (e.g., minimum length, uppercase/lowercase/symbols)
  if (password.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  // You can add further checks for uppercase, lowercase, symbols, etc. based on your security requirements.
  return null;
}

String? confirmPasswordValidator(String confirmPassword) {
  if (confirmPassword.isEmpty) {
    return 'Confirm password cannot be empty';
  }
  if (confirmPassword != textPassword.text) {
    return 'Passwords do not match';
  }
  return null;
}

}
