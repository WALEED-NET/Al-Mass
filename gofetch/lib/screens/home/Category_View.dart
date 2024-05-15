import 'package:flutter/material.dart';
import 'package:gofetch/api/api_strings.dart';
import 'package:gofetch/constants/app_constants.dart';
import 'package:gofetch/screens/more/add_category.dart';
import 'package:gofetch/screens/more/edit_category.dart';

import '../../api/api_crud.dart';
import '../../shared_wedget/button.dart';
import '../../shared_wedget/roundtext.dart';
import '../more/category_items.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}


TextEditingController textSearch = TextEditingController();

// model instance
crud _crud = crud();

getCategore() async {
  var response = await _crud.postRequest(getCategoreApi, {
    "user_id": 5.toString() // here user_id
  });
  print(response);
  return response;
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 180),
            width: media.width * 0.27,
            height: media.height * 0.7,
            decoration: BoxDecoration(
              color: app_colors.main,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(35),
                  bottomRight: Radius.circular(35)),
            ),
          ),
          SingleChildScrollView(
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
                          "Menu",
                          style: TextStyle(
                              color: app_colors.primaryText,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        Container(
                          width: 160,
                          decoration: BoxDecoration(
                              color: app_colors.main,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              Button(
                                  title: "Add Category",
                                  onPressed: () {
                                    
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return const AddCategoryView();
                                        });
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: roundtext(
                      hintText: "Search Category",
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
                    height: 30,
                  ),
                  FutureBuilder(
                    future: getCategore(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data['status'] == 'fail') {
                          return const Text("no Categories found");
                        }
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 20),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data["data"].length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => categoryItemsView(
                                          item: snapshot.data["data"][index]),
                                    ),
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, bottom: 8, right: 20),
                                      width: media.width - 100,
                                      height: 90,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 7,
                                                offset: Offset(0, 4))
                                          ]),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/img/menu_1.png",
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${snapshot.data["data"][index]["name"]}',
                                                style: TextStyle(
                                                    color:
                                                        app_colors.primaryText,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "'${snapshot.data["data"][index]["item_count"]}' items",
                                                style: TextStyle(
                                                    color: app_colors
                                                        .secondaryText,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return editCategoryView(
                                                        category: snapshot.data['data'][index],
                                                      );
                                                    });
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () async {
                                                
                                                if (snapshot.data['data'][index]
                                                            ['item_count']
                                                        .toString() ==
                                                    "0") {
                                                  var response = await _crud
                                                      .postRequest(
                                                          deleteCategoryApi, {
                                                    'category_id': snapshot
                                                        .data["data"][index]
                                                            ["category_id"]
                                                        .toString(),
                                                  });
                                                
                                                  if (response['status'] ==
                                                      'success') {
                                                    print("it is deleted");
                                                  }
                                                } else {
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

                                              },
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(17.5),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2))
                                              ]),
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/img/btn_next.png",
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text("Loading ..."));
                      }

                      return const Center(child: Text("Loadinggg ..."));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
