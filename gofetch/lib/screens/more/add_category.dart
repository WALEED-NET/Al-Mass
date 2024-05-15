import 'package:flutter/material.dart';
import 'package:gofetch/api/api_strings.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/screens/home/Category_View.dart';
import 'package:gofetch/shared_wedget/round_icon_button.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';

import '../../api/api_crud.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  TextEditingController txtCategoryName = TextEditingController();
  TextEditingController textCategoryDescription = TextEditingController();

  crud _crud = crud();


addCategory() async {
    var response = await _crud.postRequest(addCategoryApi, {
      "category_name": txtCategoryName.text,
      "category_description": textCategoryDescription.text,
      "user_id": 5.toString()
    });
    // print(response);
    if (response["status"] == 'success') {
      Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                         CategoryView()));

    // Navigator.pop(context);

    } 
    else {
      print("add categoriy Failed");
    }
  }


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      width: media.width,
      decoration: BoxDecoration(
          color: app_colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add New Category",
                style: TextStyle(
                    color: app_colors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
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
          Divider(
            color: app_colors.secondaryText.withOpacity(0.4),
            height: 1,
          ),
          const SizedBox(
            height: 15,
          ),
          roundtext(
            hintText: "Category Name",
            controller: txtCategoryName,
            bgColor: app_colors.placeholder,
          ),
          const SizedBox(
            height: 15,
          ),
         roundtext(
            hintText: "the Description ",
            controller: textCategoryDescription,
            bgColor: app_colors.placeholder,
          ),
          const SizedBox(
            height: 15,
          ),
          RoundIconButton(
              title: "Add Category",
              icon: "assets/img/add.png",
              color: app_colors.main,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              onPressed: () async {
                await addCategory();
              }),
          const SizedBox(
            height: 25,
          ),
            ],
            
          ),

    );
  }   
}