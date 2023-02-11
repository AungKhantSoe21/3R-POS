// ignore_for_file: prefer_const_constructors
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/screens/order_screen/order_detail_screen.dart';

class SaleListScreen extends StatefulWidget {
  const SaleListScreen({Key? key}) : super(key: key);

  @override
  State<SaleListScreen> createState() => _SaleListScreenState();
}

class _SaleListScreenState extends State<SaleListScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child("Order");

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Sale Reports",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: FirebaseAnimatedList(
                          query: ref,
                          itemBuilder: (context, snapshot, animation, index) {
                            Map mydata = snapshot.value as Map;
                            mydata['key'] = snapshot.key;
                            int totalPrice = 0;
                            int totalQuantity = 0;
                            for(int j = 0; j < mydata['ordered_menu'].length; j++) {
                              totalQuantity = totalQuantity + int.parse(mydata['ordered_menu'][j]['data'].length.toString());
                              for(int t = 0; t < mydata['ordered_menu'][j]['data'].length; t++) {
                                totalPrice = totalPrice + int.parse(mydata['ordered_menu'][j]['data'][t]['price']);
                              }
                            }
                            if(mydata['order_status'] == "Paid") {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (_) => OrderDetailScreen(
                                              mydata['ordered_menu'],
                                              mydata['table_no'],
                                              "${(DateTime.parse(mydata['order_time'].toString()).hour).toString().length == 1 ? "0" + (DateTime.parse(mydata['order_time'].toString()).hour).toString() : (DateTime.parse(mydata['order_time'].toString()).hour).toString()}" +
                                                  " : " +
                                                  "${(DateTime.parse(mydata['order_time'].toString()).minute).toString().length == 1 ? "0" + (DateTime.parse(mydata['order_time'].toString()).minute).toString() : (DateTime.parse(mydata['order_time'].toString()).minute).toString()}",
                                              mydata['order_status'],
                                              mydata["key"].toString(),
                                              "sale",
                                              (DateTime.parse(mydata['order_time'].toString()).day).toString() + "-" +(DateTime.parse(mydata['order_time'].toString()).month).toString() + "-" + (DateTime.parse(mydata['order_time'].toString()).year).toString(),
                                              mydata["table_key"] ?? "",
                                              totalPrice
                                            )));
                                  },
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            textRow("Table No", mydata['table_no']),
                                            textRow("Total Price", totalPrice.toString() + " Ks"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            textRow(
                                                "Time",
                                                "${(DateTime.parse(mydata['order_time'].toString()).hour).toString().length == 1 ? "0" + (DateTime.parse(mydata['order_time'].toString()).hour).toString() : (DateTime.parse(mydata['order_time'].toString()).hour).toString()}" +
                                                    " : " +
                                                    "${(DateTime.parse(mydata['order_time'].toString()).minute).toString().length == 1 ? "0" + (DateTime.parse(mydata['order_time'].toString()).minute).toString() : (DateTime.parse(mydata['order_time'].toString()).minute).toString()}"),
                                         textRow("Total Qty", totalQuantity.toString()),
                                          ],
                                        ),
                                        textRow("Date", (DateTime.parse(mydata['order_time'].toString()).day).toString() + "-" +(DateTime.parse(mydata['order_time'].toString()).month).toString() + "-" + (DateTime.parse(mydata['order_time'].toString()).year).toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget textRow(String text1, String text2,
      {Color text2Color = Colors.black}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.22,
              child: Text(text1)),
        ),
        SizedBox(width: 15, child: Text(":")),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(text2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: text2Color)))
      ],
    );
  }
}
