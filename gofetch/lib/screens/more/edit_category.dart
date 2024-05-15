import 'package:flutter/material.dart';
import 'package:gofetch/api/api_strings.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/shared_wedget/round_icon_button.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';

import '../../api/api_crud.dart';
import '../home/Category_View.dart';

class editCategoryView extends StatefulWidget {
  final category;
  const editCategoryView({super.key, required this.category});

  @override
  State<editCategoryView> createState() => _editCategoryViewState();
}

class _editCategoryViewState extends State<editCategoryView> {
  TextEditingController txtCategoryName = TextEditingController();
  TextEditingController textCategoryDescription = TextEditingController();

  crud _crud = crud();


editCategory() async {
    var response = await _crud.postRequest(editCategoryApi, {
      "category_name": txtCategoryName.text,
      "category_description": textCategoryDescription.text,
      "category_id" : widget.category['category_id'].toString()
    });

    if (response["status"] == 'success') {

      Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                         CategoryView()));
    // Navigator.pop(context);

    } 
    else {
      // print("Sing up Failed");
      print(response);
    }
  }


  @override

  void initState(){

txtCategoryName.text = widget.category['name'];
textCategoryDescription.text = widget.category['description'];

  super.initState();
}

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
                await editCategory();
              }),
          const SizedBox(
            height: 25,
          ),
            ],
            
          ),

    );
  }   
}