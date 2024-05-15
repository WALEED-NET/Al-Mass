import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/shared_wedget/button.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  bool isInputEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 46,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                      color: app_colors.primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/img/shopping_cart.png",
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: app_colors.placeholder,
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              child: Image.asset("assets/img/btn_next.png")),
          SizedBox(
            height: 15,
          ),
          Text(
            "Hi Omar",
            style: TextStyle(
                color: app_colors.primaryText,
                fontSize: 26,
                fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isInputEnabled = !isInputEnabled;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Edit",
                      style: TextStyle(
                          color: app_colors.secondaryText,
                          fontSize: 14,
                          height: 2,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 70,
                      height: 3,
                      color: isInputEnabled
                          ? app_colors.main
                          : app_colors.secondaryText,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: RoundTitleTextfield(
              title: "Name",
              hintText: "Enter Name",
              controller: txtName,
              isInputEnabled: isInputEnabled,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: RoundTitleTextfield(
              title: "Email",
              hintText: "Enter Email",
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: RoundTitleTextfield(
              title: "Mobile No",
              hintText: "Enter Mobile No",
              controller: txtMobile,
              keyboardType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: RoundTitleTextfield(
              title: "Address",
              hintText: "Enter Address",
              controller: txtAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: RoundTitleTextfield(
              title: "Password",
              hintText: "* * * * * *",
              obscureText: true,
              controller: txtPassword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: RoundTitleTextfield(
              title: "Confirm Password",
              hintText: "* * * * * *",
              obscureText: true,
              controller: txtConfirmPassword,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Button(title: "Save", onPressed: () {}),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    ));
  }
}
