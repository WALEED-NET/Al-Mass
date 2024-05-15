import 'package:flutter/material.dart';
import 'package:gofetch/api/api_crud.dart';
import 'package:gofetch/constants/app_constants.dart';
// import 'package:gofetch/shared_wedget/button.dart';
import 'package:gofetch/shared_wedget/round_icon_button.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';

import '../../api/api_strings.dart';
import '../login/login_view.dart';

class AddCustomerView extends StatefulWidget {
  const AddCustomerView({super.key});

  @override
  State<AddCustomerView> createState() => _AddCustomerViewState();
}

class _AddCustomerViewState extends State<AddCustomerView> {

  TextEditingController txtPersonName = TextEditingController();
  TextEditingController txtPersonPhoneNo = TextEditingController();
  TextEditingController txtPersonAddress = TextEditingController();
  // TextEditingController txtPersonAddress = TextEditingController();
  // TextEditingController txtCardCode = TextEditingController();
  // TextEditingController txtFirstName = TextEditingController();
  // TextEditingController txtLastName = TextEditingController();
  // bool isAnyTime = false;
crud _crud = crud();
 
  addPerson() async {
    var response = await _crud.postRequest(addCustomerApi, {
      "customer_name": txtPersonName.text,
      "customer_phone_number": txtPersonPhoneNo.text,
      "customer_address": txtPersonAddress.text,
      "customer_user_id":5.toString()
    });
    print(response);
    if (response["status"] == 'success') {

Navigator.pop(context);
    //   // Navigator.of(context)
    //   //     .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    //    Navigator.push(context,
    //                     MaterialPageRoute(builder: (context) => LoginView()));
    } 
    else {
      print("Sing up Failed");
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
                "Add New Customer",
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
            hintText: "Customer Name",
            controller: txtPersonName,
            bgColor: app_colors.placeholder,
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 15,
          ),
         roundtext(
            hintText: "the PhonNumber ",
            controller: txtPersonPhoneNo,
            bgColor: app_colors.placeholder,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 15,
          ),
          roundtext(
            hintText: "the Address ",
            controller: txtPersonAddress,
            bgColor: app_colors.placeholder,
            // keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 15,
          ),
          //  Row(
          //   // mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text(
          //       "Date of take",
          //       style: TextStyle(
          //           color: app_colors.primaryText,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w600),
          //     ),
          //     const Spacer(),
          //     SizedBox(
          //       width: 100,
          //       child: roundtext(
          //         hintText: "MM",
          //         // controller: txtCardMonth,
          //         bgColor: app_colors.placeholder,
          //         keyboardType: TextInputType.number,
          //       ),
          //     ),
          //     const SizedBox(width: 25),
          //     SizedBox(
          //       width: 100,
          //       child: roundtext(
          //         hintText: "YYYY",
          //         // controller: txtCardYear,
          //         bgColor: app_colors.placeholder,
          //         keyboardType: TextInputType.number,
          //       ),
          //     ),
           
          //   ],
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          //  Row(
          //   // mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text(
          //       "Date of return",
          //       style: TextStyle(
          //           color: app_colors.primaryText,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w600),
          //     ),
          //     const Spacer(),
          //     SizedBox(
          //       width: 100,
          //       child: roundtext(
          //         hintText: "MM",
          //         // controller: txtCardMonth,
          //         bgColor: app_colors.placeholder,
          //         keyboardType: TextInputType.number,
          //       ),
          //     ),
          //     const SizedBox(width: 25),
          //     SizedBox(
          //       width: 100,
          //       child: roundtext(
          //         hintText: "YYYY",
          //         // controller: txtCardYear,
          //         bgColor: app_colors.placeholder,
          //         keyboardType: TextInputType.number,
          //       ),
          //     ),
             
          //   ],
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
         
          RoundIconButton(
              title: "Add Customer",
              icon: "assets/img/add.png",
              color: app_colors.main,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              onPressed: () async {
                await addPerson();
              }),
          const SizedBox(
            height: 25,
          ),
            ],
            
          ),

    );
  }   
}