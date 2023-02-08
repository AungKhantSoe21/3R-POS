// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/screens/menu_screens/new_menu_screen.dart';
import 'package:r_pos/utils/constant_color.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ref = FirebaseDatabase.instance.ref();
  List categoryList = [];
  List items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewMenuScreen()));
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
      body: StreamBuilder(
          stream: ref.child("Category").onValue.asBroadcastStream(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final map = snapshot.data.snapshot.value;
              categoryList = map.values.toList();
              categoryList.sort(
                  (a, b) => a['category_name'].compareTo(b['category_name']));
              return DefaultTabController(
                length: categoryList.length,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      indicatorColor: primaryColor,
                      tabs: [
                        for (int i = 0; i < categoryList.length; i++)
                          Tab(
                            child: Text(
                              categoryList[i]['category_name'],
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        for (int i = 0; i < categoryList.length; i++)
                          FirebaseAnimatedList(
                              query: ref
                                  .child("Item")
                                  .child(categoryList[i]["category_name"]),
                              itemBuilder: (context, snapshot, animation, index) {
                                Map mydata = snapshot.value as Map;
                                mydata['key'] = snapshot.key;

                                if(snapshot.hasChild("image_path") != true) {
                                  return Center(
                                    child: Text("No menu for this category!"),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.45,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            border: Border.all(),
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: mydata['image_path'].toString() == "null" || mydata['image_path'].isEmpty == true
                                              ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/defaultImage%2Ffood.jpg?alt=media&token=5d34f868-8500-4062-a6f9-2e223ea7eb2f")
                                              : NetworkImage(mydata['image_path']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  mydata['item_name'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10,),
                                                Text(
                                                  mydata['item_price'] + " Ks",
                                                  style: TextStyle(
                                                    fontSize: 14
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
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
    );
  }
}
