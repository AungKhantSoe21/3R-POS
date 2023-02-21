// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:r_pos/screens/home_screen.dart';

import 'package:r_pos/screens/menu_screens/new_menu_screen.dart';
import 'package:r_pos/screens/menu_screens/recommend_for_you_screen.dart';
import 'package:r_pos/screens/menu_screens/today_special_screen.dart';
import 'package:r_pos/screens/menu_screens/update_menu_screen.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/widgets/loader.dart';
import 'package:r_pos/widgets/toast_message.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ref = FirebaseDatabase.instance.ref();
  List categoryList = [];
  List items = [];
  String userRole = "";

  @override
  Widget build(BuildContext context) {
    userRole = User.user[1];

    return Scaffold(
      floatingActionButton: userRole != "Admin"
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => NewMenuScreen()));
              },
              backgroundColor: primaryColor,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.restaurant,
                    color: Colors.white,
                    size: 18,
                  ),
                  Positioned(
                    left: 12,
                    bottom: 13,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TodaySpecialScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 80,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Today",
                            style: TextStyle(
                                color: Color(0xffFFD700),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Special",
                          style: TextStyle(
                              color: Color(0xffFFD700),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RecommendForYou()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 80,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Popular",
                            style: TextStyle(
                                color: Color(0xffFFD700),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "At This Restaurant",
                          style: TextStyle(
                            color: Color(0xffFFD700),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: ref.child("Category").onValue.asBroadcastStream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final map = snapshot.data.snapshot.value;
                    categoryList = map.values.toList();
                    categoryList.sort((a, b) =>
                        a['category_name'].compareTo(b['category_name']));
                    return DefaultTabController(
                      length: categoryList.length,
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: primaryColor,
                            tabs: [
                              for (int i = 0; i < categoryList.length; i++)
                                Tab(
                                  child: Text(
                                    categoryList[i]['category_name'],
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          Expanded(
                              child: TabBarView(
                            children: [
                              for (int i = 0; i < categoryList.length; i++)
                                FirebaseAnimatedList(
                                    query: ref.child("Item").child(categoryList[i]["category_name"]).orderByChild("item_name"),
                                    itemBuilder: (context, snapshot, animation, indxe) {
                                      Map mydata = snapshot.value as Map;
                                      mydata['key'] = snapshot.key;
                                      if (snapshot.hasChild("image_path") !=
                                          true) {
                                        return Center(
                                          child: Text(
                                            "No menu for this category!",
                                          ),
                                        );
                                      } else {
                                        if(userRole != "Admin" && mydata["item_status"] == "Unavailable") {
                                          return Container();
                                        } else {
                                        return InkWell(
                                          onTap: () {
                                            toastMessage(
                                              "Detail functionality will release on V2",
                                              fontSize: 14,
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 10,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.30,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          border: Border.all(),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                            10,
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                            10,
                                                          ),
                                                          child: CachedNetworkImage(
                                                            imageUrl: mydata['image_path']
                                                                            .toString() ==
                                                                        "null" ||
                                                                    mydata['image_path']
                                                                            .isEmpty ==
                                                                        true
                                                                ? "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/defaultImage%2Ffood.jpg?alt=media&token=5d34f868-8500-4062-a6f9-2e223ea7eb2f"
                                                                : mydata[
                                                                    'image_path'],
                                                            placeholder:
                                                                (context, s) =>
                                                                    Loader(
                                                              Colors.white,
                                                              2,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        )),
                                                    if(mydata["today_special"] == "True")
                                                    Positioned(
                                                          top: 5,
                                                          right: 5,
                                                          child: Icon(Icons.star, color: Color(0xffFFD700), size: 15,)
                                                        )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 15.0,
                                                    ),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.60,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            mydata['item_name'],
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            mydata['item_price'] +
                                                                " Ks",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if(userRole == "Admin")
                                                PopupMenuButton<int>(
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 1,
                                                      child: Row(
                                                        children: const [
                                                          Icon(Icons.edit),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("Edit"),
                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 2,
                                                      child: Row(
                                                        children: const [
                                                          Icon(Icons.delete),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("Delete"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  color: Colors.grey,
                                                  elevation: 2,
                                                  onSelected: (value) {
                                                    if(value == 1) {
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(builder: (_) => UpdateMenuScreen(
                                                          itemKey: mydata["key"], 
                                                          imagePath: mydata["image_path"], 
                                                          itemName: mydata["item_name"], 
                                                          itemPrice: mydata["item_price"], 
                                                          itemStatus: mydata["item_status"], 
                                                          todaySpecial: mydata["today_special"] ?? "False",
                                                          itemCategory: categoryList[i]["category_name"],
                                                        ))
                                                      );
                                                    } else  {
                                                      showDialog(
                                                        context: context, 
                                                        builder: (c) => AlertDialog(
                                                          title: Text("Warning"),
                                                          content: Text("Are you sure?"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              }, 
                                                              child: Text("No")
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                ref.child("Item").child(categoryList[i]["category_name"]).child(mydata["key"]).remove();
                                                                Navigator.pop(context);
                                                                toastMessage("Delete successful", txtColor: Colors.red);
                                                              }, 
                                                              child: Text("Yes", style: TextStyle(color: Colors.red),)
                                                            )
                                                          ],
                                                        )
                                                      );
                                                    }
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      }
                                    })
                            ],
                          ))
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
