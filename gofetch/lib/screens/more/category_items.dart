import 'package:flutter/material.dart';
import 'package:gofetch/api/api_strings.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/screens/home/Category_View.dart';
// import 'package:gofetch/screens/home/item_details_view.dart';
// import 'package:gofetch/screens/home/s.dart';
import 'package:gofetch/screens/more/add_item.dart';
import 'package:gofetch/screens/more/edit_item.dart';
import 'package:gofetch/shared_wedget/roundtext.dart';
import 'package:http/http.dart';

import '../../api/api_crud.dart';
import '../../shared_wedget/button.dart';
import '../../shared_wedget/menu_item_row.dart';

class categoryItemsView extends StatefulWidget {
  // final Map<dynamic, dynamic> menuObject;
  final item;
  const categoryItemsView({super.key, required this.item});

  @override
  State<categoryItemsView> createState() => _categoryItemsViewState();
}

class _categoryItemsViewState extends State<categoryItemsView> {
  TextEditingController textSearch = TextEditingController();


   // model instance
  crud _crud = crud();

  getCategoryItems() async {
    var response = await _crud.postRequest(getCategoryItemsApi, {
      "category_id": widget.item['category_id'].toString()
    });
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                       "Items",
                        style: TextStyle(
                            color: app_colors.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                          width: 160,
                          decoration: BoxDecoration(
                            color: app_colors.main,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: 
                           Button(
                        title: "Add Item",
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const CheckoutView(),
                          //   ),
                          // );
                            showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return  AddItemView(item: [widget.item['user_id'], widget.item['category_id']]);
                            });
                        }),
                        ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Image.asset(
                    //     "assets/img/shopping_cart.png",
                    //     width: 25,
                    //     height: 25,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: roundtext(
                  hintText: "Search Food",
                  bgColor: app_colors.placeholder,
                  controller: textSearch,
                  left: Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Image.asset(
                      "assets/img/search.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: getCategoryItems(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["status"] == "fail") {
                      return Text("no data");
                    }
                    return  ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: snapshot.data["data"].length,
                itemBuilder: ((context, index) {
                  // var menuObject = menuItemsArray[index] as Map? ?? {};
                  return 
                  CustomListTile(
                    onTap: (){
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       // builder: (context) => const ItemDetailsView()),
                      //       builder: (context) => const MyWidget()),
                      // );
                    },
                    height: 100,
                    leading: Image.network(
                     "$imageslink/${snapshot.data["data"][index]["image"]}",
                      width: 80,
                      // height: 100,
                      ) ?? Icon(Icons.person_off),
                    subTitle: Row(
                      children: [

                        // Text('${snapshot.data["data"][index]["description"]}'),
                        Text('${snapshot.data["data"][index]["daily_rental_price"]}'),
                        Text('${snapshot.data["data"][index]["item_id"]}'),
                        // Text('${snapshot.data["data"][index]["daily_rental_price"]}'),
                      ],
                    ),
                    title: Text('${snapshot.data["data"][index]["name"]}'),
                    trailing:
                     Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return  editItemView(
                                item: snapshot.data['data'][index]);
                            });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                       var response= await _crud.postRequest(deleteItemApi, {
                        'item_id': snapshot.data["data"][index]["item_id"].toString(),
                        'imagename' : snapshot.data['data'][index]['image'].toString(),
                       });
                       print(response);
                       print(snapshot.data["data"][index]["item_id"].toString());
                       print(snapshot.data['data'][index]['image'].toString());
                       if (response['status'] == 'success') {
                        print("it is deleted");
                       }
                      },
                    ),
                  ],
                ),
                    
                  );
                  
                }
                
                ),
                  );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text("Loading ..."));
                      }

                      return const Center(child: Text("Loadinggg ..."));
                    
                },)
               
              // ListView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   padding: EdgeInsets.zero,
              //   itemCount: menuItemsArray.length,
              //   itemBuilder: ((context, index) {
              //     var menuObject = menuItemsArray[index] as Map? ?? {};
              //     return 
              //     CustomListTile(
              //       onTap: (){
              //           Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               // builder: (context) => const ItemDetailsView()),
              //               builder: (context) => const MyWidget()),
              //         );
              //       },
              //       height: 100,
              //       leading: Image.asset(
              //         menuObject["image"].toString(),
              //         width: 80,
              //         // height: 100,
              //         ),
              //       subTitle: Text("menuObject[name]"),
              //       title: Text(menuObject["name"]),
              //       trailing:
              //        Row(
              //     children: [
              //       IconButton(
              //         icon: Icon(Icons.edit),
              //         onPressed: () {
              //           // Handle update functionality here
              //         },
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.delete),
              //         onPressed: () {
              //           // Handle delete functionality here
              //         },
              //       ),
              //     ],
              //   ),
                    
              //     );
                  
              //   }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
