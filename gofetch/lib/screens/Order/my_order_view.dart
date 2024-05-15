import 'package:flutter/material.dart';
import 'package:gofetch/constants/app_constants.dart';
// import 'package:gofetch/screens/more/add_category.dart';
// import 'package:gofetch/screens/Order/checkout_view.dart';
// import 'package:gofetch/screens/Order/thank_you_message.dart';
import 'package:gofetch/shared_wedget/button.dart';
// import 'package:http/http.dart';

import '../../api/api_crud.dart';
import '../../api/api_strings.dart';
import '../../shared_wedget/roundtext.dart';
// import '../../shared_wedget/tab_button.dart';
// import '../more/add_customer.dart';
// import '../more/add_item.dart';
// import '../more/add_number_of_item.dart';

class MyOrderView extends StatefulWidget {
  final customer;
  const MyOrderView({super.key, required this.customer});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
 
  TextEditingController restController = TextEditingController();
  TextEditingController payidController = TextEditingController();

  bool isDeleted = false;

  crud _crud = crud();
  

  getInvoiceItem() async {
    var response = await _crud.postRequest(getInvoiceItemApi, {
      "invoice_id": widget.customer["invoice_id"].toString()
    });
    // print(response);
    return response;
  }


  getTotalInvoicePrice() async {
    var totalResponse = await _crud.postRequest(getTotalInvoicePriceApi, {
      "invoice_id": widget.customer["invoice_id"].toString(),
    });
    // print(totalResponse);
    return totalResponse;  
  }
  updatInvoice() async {
    var inoviceResponse = await _crud.postRequest(getTotalInvoicePriceApi, {
      "invoice_id": widget.customer["invoice_id"].toString(),
      "invoice_date": selecteDate.toString(),
      "status":status,
      "total_price":totalInvoicePrice.toString()

    });
    print(widget.customer["invoice_id"]);
    print(selecteDate);
    print(status);
    print(totalInvoicePrice);
    print(inoviceResponse);
    if(inoviceResponse["status"] == 'success'){
      // return inoviceResponse; 
      Navigator.pop(context);
    }
    // print(totalResponse); 
  }


  DateTime selecteDate = DateTime.now();

  String status = "Unreturn";
  bool isReturn = false;
  bool isUnreturn = true;

  var totalInvoicePrice;



  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: app_colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("assets/img/btn_back.png",
                          width: 20, height: 20),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        "My Order",
                        style: TextStyle(
                            color: app_colors.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/img/shop_logo.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.customer["name"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: app_colors.primaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                         
                              Icon(
                                Icons.phone_android,
                                color: app_colors.main,
                                size: 20,
                              ),
                              Text(
                                "Phon number : ${widget.customer["phone_number"].toString()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: app_colors.secondaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/img/location-pin.png",
                                width: 13,
                                height: 13,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  "City :  ${widget.customer["address"]}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: app_colors.secondaryText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: app_colors.textFiled),
                // ListView.separated used to separate between the items of the listView by a thing we want
                child: FutureBuilder(
                  future: getInvoiceItem(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                   if (snapshot.connectionState == ConnectionState.waiting) {
                     return const Center(child: Text("Loading ..."));
                   } else if (snapshot.hasData){
                    if (snapshot.data["status"] == "fail") {
                       return const Center(
                         child: Text(
                          "no Items related",
                          ),
                       );
                    }else{
                      return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data["data"].length,
                    // here we write how the separator will be
                    separatorBuilder: ((context, index) => Divider(
                          // dont make the line reach(يصل إلى) the end of the left make an empty space we will give you it
                          indent: 25,
                          endIndent: 25,
                          color: app_colors.secondaryText.withOpacity(0.5),
                          height: 1,
                        )),
                    itemBuilder: ((context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${snapshot.data["data"][index]["name"]} x${snapshot.data["data"][index]["quantity"].toString()}",
                                style: TextStyle(
                                    color: app_colors.primaryText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                "rental price * quantity :  \$${double.parse(snapshot.data["data"][index]["daily_rental_price"]) * int.parse(snapshot.data["data"][index]["quantity"])}".toString(),

                              style: TextStyle(
                                  color: app_colors.primaryText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.cancel,
                                size: 10,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  );

                    }
                   }else {
                    return const Center(child: Text("Loadinggg ..."));
                   }
                  
  }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add The Inovice Date :",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: app_colors.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        TextButton.icon(
                          onPressed: () async{
                            final DateTime? dateTime = await showDatePicker(
                              context: context, 
                              initialDate: selecteDate,
                              firstDate: DateTime(selecteDate.year,selecteDate.month),
                              lastDate: DateTime(3000)
                              );
                              if(dateTime != null){
                                setState(() {
                                  selecteDate = dateTime;
                                });
                              }
                          },
                          icon: Icon(Icons.add, color: app_colors.main),
                          label: Text(
                            "Add Invoice Date",
                            style: TextStyle(
                                color: app_colors.main,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                      children: [
                        Text(
                          "Date selected is :",
                          style: TextStyle(
                                  color: app_colors.primaryText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${selecteDate.year}/${selecteDate.month}/${selecteDate.day}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                                  color: app_colors.main,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: app_colors.secondaryText.withOpacity(0.5),
                      height: 1,
                    ),

                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Is return",
                              style: TextStyle(
                                      color: app_colors.primaryText,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                              ),
                            Checkbox(
                              value: isReturn,
                              activeColor: app_colors.main,
                              tristate: true,
                              onChanged: (value) {
                                setState(() {
                                  isUnreturn =! isUnreturn;
                                  isReturn =! isReturn;
                                  status ="Return";
                                });
                              },
                               ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Is unreturn",
                              style: TextStyle(
                                      color: app_colors.primaryText,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                              ),
                            Checkbox(
                              value: isUnreturn,
                              activeColor: app_colors.main,
                              tristate: true,
                              onChanged: (value) {
                                setState(() {
                                  setState(() {
                                  isReturn =! isReturn;
                                  isUnreturn =! isUnreturn;
                                 
                                });
                                });
                              },
                               ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: app_colors.secondaryText.withOpacity(0.5),
                      height: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder(
                      future: getTotalInvoicePrice(),
                      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                         return const Center(child: Text("Loading ..."));
                      } else if (snapshot.hasData) {
                        if (snapshot.data["status"] == "fail") {
                          return Text("no data");
                        }else{

                         
                          totalInvoicePrice = snapshot.data["data"][0]["total"];

                          return Column(
                            children: [
                              Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "How much pay?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: app_colors.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                      roundTextWithOnChanged(
                        controller: payidController,
                        keyboardType: TextInputType.number,
                          hintText: "Write the paid cost :",
                          onSubmitted: (value) {
                            double total = double.parse(snapshot.data["data"][0]["total"]);
                            int text = int.parse(payidController.text);
                            double result = total - text;
                            String finalResult = result.toString();
                            restController.text = finalResult ;
                            
                            // print("controller is : $restController.text");
                            // print(total);
                            // print(text);
                            // print(result);
                            setState(() {
                              
                            });                        
                          },
                        ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "how much rest?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: app_colors.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        Text( 
                          // "\$2",
                          restController.text,
                          style: TextStyle(
                              color: app_colors.main,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "how much payied?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: app_colors.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        Text( 
                          // "\$2",
                          payidController.text,
                          style: TextStyle(
                              color: app_colors.main,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: app_colors.secondaryText.withOpacity(0.5),
                      height: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: app_colors.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          snapshot.data["data"][0]["total"].toString(),
                        //  total["data"][0]["total"].toString()"",
                          style: TextStyle(
                              color: app_colors.main,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                            ],
                          );
                        }
                      }else{
                        return const Center(child: Text("Loadinggg ..."));
                      }
                      }
                      ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "How much pay?",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           color: app_colors.primaryText,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w700),
                    //     ),
                    //     Text(
                    //       "\$68",
                    //       style: TextStyle(
                    //           color: app_colors.main,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w700),
                    //     )
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "How much rest?",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           color: app_colors.primaryText,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w700),
                    //     ),
                    //     Text(
                    //       "\$2",
                    //       style: TextStyle(
                    //           color: app_colors.main,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w700),
                    //     )
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Divider(
                    //   color: app_colors.secondaryText.withOpacity(0.5),
                    //   height: 1,
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Total",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           color: app_colors.primaryText,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w700),
                    //     ),
                    //     Text(
                    //     " total.toString()",
                    //     //  total["data"][0]["total"].toString()"",
                    //       style: TextStyle(
                    //           color: app_colors.main,
                    //           fontSize: 22,
                    //           fontWeight: FontWeight.w700),
                    //     )
                    //   ],
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    Button(
                        title: "OK",
                        onPressed: () async {
                          await updatInvoice();
                        }),
                    const SizedBox(
                      height: 20,
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
}
