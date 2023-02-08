// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/screens/order_screen/new_order_screen.dart';
import 'package:r_pos/utils/constant_color.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child("Order");
    
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => NewOrderScreen(const []))
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shadowColor: Colors.transparent,
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                child: Text("New Order",),
              ),
            ),
          ),
          SizedBox(height: 25,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                border: Border.fromBorderSide(
                  BorderSide(color: Colors.black)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text("Order Lists", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1, color: Colors.black,),
                  SizedBox(height: 10,),
                  Expanded(
                    child: SizedBox(
                      child: StreamBuilder(
                        stream: ref.onValue,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData) {
                            final map = snapshot.data.snapshot.value;
                            List order = map.values.toList();
                            return GridView.builder(  
                              itemCount: order.length,  
                              physics: BouncingScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                  crossAxisCount: 2,  
                                  crossAxisSpacing: 10.0,  
                                  mainAxisSpacing: 15.0,
                                  childAspectRatio: 1.5
                              ),  
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              itemBuilder: (BuildContext context, int index){  
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      textRow("Table No", order[index]['table_no']),
                                      textRow(
                                        "Time", 
                                        "${(DateTime.parse(order[index]['order_time'].toString()).hour).toString().length == 1 ? "0" + (DateTime.parse(order[index]['order_time'].toString()).hour).toString() : (DateTime.parse(order[index]['order_time'].toString()).hour).toString()}" + " : " + 
                                        "${(DateTime.parse(order[index]['order_time'].toString()).minute).toString().length == 1 ? "0" + (DateTime.parse(order[index]['order_time'].toString()).minute).toString() : (DateTime.parse(order[index]['order_time'].toString()).minute).toString()}"
                                      ),
                                      textRow("Status", order[index]['order_status'], text2Color: order[index]['order_status'] == "Confirm" ? Colors.green : Colors.yellow),
                                    ],
                                  ),
                                );  
                              },  
                            );
                          } else {
                            return Container();
                          }
                        }
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget textRow(String text1, String text2, {Color text2Color = Colors.black}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            child: Text(text1)
          ),
        ),
        SizedBox(
          width: 15,
          child: Text(":")
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Text(text2, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: text2Color))
        )
      ],
    );
  }
}