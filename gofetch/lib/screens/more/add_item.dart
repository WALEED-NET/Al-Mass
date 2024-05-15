import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gofetch/api/api_strings.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/shared_wedget/button.dart';
import 'package:gofetch/shared_wedget/round_icon_button.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/api_crud.dart';


class AddItemView extends StatefulWidget {
  final item;
  const AddItemView({super.key, required this.item});

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  TextEditingController txtItemName = TextEditingController();
  TextEditingController txtItemDescription = TextEditingController();
  TextEditingController txtItemPrice = TextEditingController();
  // TextEditingController txtCardCode = TextEditingController();
  // TextEditingController txtFirstName = TextEditingController();
  // TextEditingController txtLastName = TextEditingController();
  // bool isAnyTime = false;

    File? myfile;

// model instance
  final crud _crud = crud();

  addItem() async {
    // this is for validate that the image is not null
    // if (myfile== null) return

    var response = await _crud.postRequestImage(
        addItemApi,
        {
          "category_id":widget.item[1].toString(),
          "user_id": widget.item[0].toString(),

          "item_name": txtItemName.text,
          "item_description": txtItemDescription.text,
          "rental_price_per_day":txtItemPrice.text
        },
        myfile!);

    // print(response);
    if (response["status"] == 'success') {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => userProductsView()),
      //   ModalRoute.withName('/'),
      // );
      Navigator.pop(context);
    } else {
      print("Sing up Failed");
      // print(response);
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
                "Add New Item",
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
            hintText: "Item Name",
            controller: txtItemName,
            bgColor: app_colors.placeholder,
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 15,
          ),
         roundtext(
            hintText: "the Description ",
            controller: txtItemDescription,
            bgColor: app_colors.placeholder,
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 15,
          ),
         roundtext(
            hintText: "the Price ",
            controller: txtItemPrice,
            bgColor: app_colors.placeholder,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 15,
          ),
          RoundIconButton(
              title: "Add Image",
              icon: "assets/img/add.png",
              color: app_colors.main,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              onPressed: () {
                showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: InkWell(
                          // the logic of adding an image

                          onTap: () async {
                            XFile? xfile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            // we declare the variable ' myfile ' above in the beging
                            // and use it in the postRequestImage parameter
                            myfile = File(xfile!.path);
                            Navigator.of(context).pop();
                          },

                          child: Text(
                            "choose image from Gallery",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
              }),
          const SizedBox(
            height: 25,
          ),
          RoundIconButton(
              title: "Add Item",
              icon: "assets/img/add.png",
              color: app_colors.main,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              onPressed: () async {
                addItem();
              }),
          const SizedBox(
            height: 25,
          ),
            ],
            
          ),

    );
  }   
}