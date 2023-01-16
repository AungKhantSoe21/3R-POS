import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shadowColor: Colors.transparent,
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                child: Text("New Order", style: TextStyle(color: Colors.black),),
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
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                          );
                        }, 
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            height: 15,
                          );
                        }, 
                        itemCount: 15
                      ),
                    )
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}