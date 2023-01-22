import 'package:flutter/material.dart';
import 'package:r_pos/screens/menu_screens/new_menu_screen.dart';
import 'package:r_pos/utils/constant_color.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List categoryList = ["Bar", "Kitchen", "Beverage", "Launch", "Breakfast"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => NewMenuScreen())
          );
        },
        backgroundColor: primaryColor,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Icons.restaurant,
              color: Colors.black,
              size: 18,
            ),
            Positioned(
              left: 12,
              bottom: 13,
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 14,
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: categoryList.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: primaryColor,
              tabs: [
                for(int i = 0; i < categoryList.length; i++)
                Tab( 
                  child: Text(categoryList[i], style: TextStyle(
                    color: Colors.black
                  ),),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  for(int i = 0; i < categoryList.length; i++)
                  GridView.builder(
                    itemCount: 8,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                      crossAxisCount: 2,  
                      crossAxisSpacing: 10.0,  
                      mainAxisSpacing: 15.0  
                    ), 
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    itemBuilder: (BuildContext context, int index){ 
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: AssetImage("assets/images/default_menu.png"), fit: BoxFit.cover)
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: SizedBox(child: Text("BB Q Style", style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                          )
                        ],
                      );
                    },
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}