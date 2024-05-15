import 'package:flutter/material.dart';
import 'package:gofetch/api/api_strings.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/shared_wedget/button.dart';
import 'package:gofetch/shared_wedget/round_icon_button.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';
import 'package:http/http.dart';

import '../../api/api_crud.dart';

class AddNumberView extends StatefulWidget {
  final item;
  const AddNumberView({super.key, required this.item});

  @override
  State<AddNumberView> createState() => _AddNumberViewState();
}

class _AddNumberViewState extends State<AddNumberView> {
  TextEditingController txtCategoryName = TextEditingController();
  TextEditingController textCategoryDescription = TextEditingController();
 
  double price = 15;
  int quantity = 1;

  crud _crud = crud();

getCustomer() async {
  var response = await _crud.postRequest(getCustomerApi, {
    "user_id": 5.toString() // here user_id
  });
  if (response["status"] == 'success') {
    
      return response;

    } else {
      print("Sing up Failed");
      print(response);
    };
}



addInvoiceItem() async {
  var response = await _crud.postRequest(addInvoiceItemApi, {
    // "user_id": 5.toString() // here user_id
    "customer_name" :selectedName.toString(),
    "item_id" :widget.item["item_id"].toString(),
    "quantity": quantity.toString()

  });
  print(response);
  print(selectedName);
  print(widget.item["item_id"].toString());
  print(quantity.toString());
    if (response != null && response["status"] == 'success') {
 
      Navigator.pop(context);

    } 
    if (response == null ) {
      showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Unable to Delete Category'),
                                                        content: const Text(
                                                          'You can\'t delete this Category because it has related Items. '
                                                          'First, delete all the items related to it, and then you can delete it.',
                                                        ),
                                                        actions: <Widget>[
                                                          ElevatedButton(
                                                            child: const Text(
                                                                'OK'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
    }
    else {
      // print("Sing up Failed");
      print('Response: $response');
    };

}



String selectedName = ".";


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
                    "Add To Person",
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
        
              SizedBox(
                height: 15,
              ),

              Container(
  height: 200,

  child: FutureBuilder(
    future: getCustomer(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data["status"] == "fail") {
          return Text("no data");
        }
        return  ListView.builder(
      itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index) {
      
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: ()  {
                        
                        print("tapped '${snapshot.data["data"][index]["name"]}'");
                     
                          
                        // print(selectedName);
                        setState(() {
                          selectedName = snapshot.data["data"][index]["name"];
                        });
                        print(selectedName);
                      },
                      child: Container(
                        width: double.infinity,
                        color: app_colors.main,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '${snapshot.data["data"][index]["name"]}',
                              style: TextStyle(
                                
                                color: app_colors.placeholder, 
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                              ),
                             
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 2,)
                  ],
                );
              // }
      },
    );
    
      }
       if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text("Loading ..."));
                      }

                      return const Center(child: Text("Loadinggg ..."));
  
    },
    
  ),
),
              SizedBox(
                height: 15,
              ),
               Row(
                 children: [
                   Text(
            "Selected Customer  :  ",
            style: TextStyle( 
              color: app_colors.primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
                   Text(
            selectedName,
            style: TextStyle(
              color: app_colors.main,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),

                 ],
               ),
            SizedBox(
                height: 15,
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Text(
                      "Number of Item",
                      style: TextStyle(
                          color: app_colors.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        quantity = quantity - 1;

                        if (quantity < 1) {
                          quantity = 1;
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: app_colors.main,
                            borderRadius: BorderRadius.circular(12.5)),
                        child: Text(
                          "-",
                          style: TextStyle(
                              color: app_colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: app_colors.main,
                          ),
                          borderRadius: BorderRadius.circular(12.5)),
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(
                            color: app_colors.main,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        quantity = quantity + 1;

                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: app_colors.main,
                            borderRadius: BorderRadius.circular(12.5)),
                        child: Text(
                          "+",
                          style: TextStyle(
                              color: app_colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
            height: 25,
          ),
              RoundIconButton(
              title: "Add Item To Person",
              icon: "assets/img/add.png",
              color: app_colors.main,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              onPressed: ()  async {
                await addInvoiceItem();
              }),
          const SizedBox(
            height: 15,
          ),
            ]
            )
            );

      }
}


