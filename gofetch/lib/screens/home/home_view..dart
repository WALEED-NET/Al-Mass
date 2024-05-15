import 'package:flutter/material.dart';
import 'package:gofetch/api/api_strings.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/screens/Order/my_order_view.dart';
import 'package:gofetch/screens/more/add_customer.dart';
import 'package:gofetch/shared_wedget/All_Customerst_Row.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';
import 'package:gofetch/shared_wedget/view_all_title.dart';

import '../../api/api_crud.dart';
import '../../shared_wedget/button.dart';

class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController textSearch = TextEditingController();

  
  crud _crud = crud();

  getCustomerInvoice() async {
    var response = await _crud.postRequest(getCustomerInvoiceApi, {
      "user_id": 5.toString() // here user_id
    });
    // print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffDfDfD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi ",
                      style: TextStyle(
                          color: app_colors.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                     Container(
                          width: 160,
                          decoration: BoxDecoration(
                            color: app_colors.main,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               
                            Button(
                        title: "Add Customer",
                        onPressed: () {
                      
                            showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return const AddCustomerView();
                            });
                        }),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: roundtext(
                    hintText: "Search Restaurant",
                    controller: textSearch,
                    bgColor: app_colors.placeholder,
                    left: Container(
                      alignment: Alignment.center,
                      width: 15,
                      child: Image.asset(
                        "assets/img/search.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ViewAllTitleRow(
                    title: "All Invocis",
                    onTap: () {},
                  )),

              FutureBuilder(
                future: getCustomerInvoice(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["status"] == "fail") {
                      return const Text(
                        "There is No Customers Add New Customers \nfrom 'Add Customer' button above ",
                        textAlign: TextAlign.center,
                        );
                    }
                    return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: snapshot.data["data"].length,
                    itemBuilder: ((context, index) {
                
                      return AllCustomerstRow(
                          info: snapshot.data["data"][index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  MyOrderView(customer: snapshot.data["data"][index]),
                              ),
                            );
                          });
                    }));

                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text("Loading ..."));
                      }

                      return const Center(child: Text("Loadinggg ..."));
                    

                },
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
