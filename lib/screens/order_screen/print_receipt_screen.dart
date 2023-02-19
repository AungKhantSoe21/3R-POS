// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_text.dart';

class PrintReceiptScreen extends StatefulWidget {
  String tableNo = "";
  String date = "";
  String time = "";
  List data = [];
  int price = 0;
  PrintReceiptScreen(this.tableNo, this.date, this.time, this.data, this.price, {Key? key}) : super(key: key);

  @override
  State<PrintReceiptScreen> createState() => _PrintReceiptScreenState();
}

class _PrintReceiptScreenState extends State<PrintReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: Text("Bill Preview", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
        centerTitle: true,
        // actions: [
          // IconButton(
          //   onPressed: () {
          //     // toastMessage("Bill P");
          //   }, 
          //   icon: Icon(Icons.print, color: Colors.white,)
          // )
        // ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Center(child: SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset("assets/images/logo.png"),
            ),
          ),),
          SizedBox(height: 7,),
          Center(
            child: Text("Bill check preview"),
          ),
          Divider(thickness: 1, color: Colors.black,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Table : ${widget.tableNo}"),
              ), 
              Text("Time : ${widget.time}"),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text("Date : ${widget.date}"),
              )
            ],
          ),
          Divider(thickness: 1, color: Colors.black,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                // border: Border.fromBorderSide(
                //   BorderSide(color: Colors.black)
                // )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Table(
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide())
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Center(child: Text('Item', style: TextStyle(fontSize: 14.0))),
                                ),  
                                Center(child: Text('Qty', style: TextStyle(fontSize: 14.0))),  
                                Center(child: Text('Price', style: TextStyle(fontSize: 14.0))), 
                                Center(child: Text('Net Amount', style: TextStyle(fontSize: 14.0))), 
                              ]
                            ),
                            for(int i = 0; i < widget.data.length; i++)
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text(widget.data[i]["data"][0]["name"].toString(), style: TextStyle(fontSize: 14.0))),
                                ),  
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text(widget.data[i]["data"].length.toString(), style: TextStyle(fontSize: 14.0))),
                                ),  
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text((widget.data[i]["data"][0]["price"]).toString() + " Ks", style: TextStyle(fontSize: 14.0))),
                                ), 
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text((int.parse(widget.data[i]["data"][0]["price"].toString()) * widget.data[i]["data"].length).toString() + " Ks", style: TextStyle(fontSize: 14.0))),
                                ), 
                              ]
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('', style: TextStyle(fontSize: 14.0))),
                                ),  
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('', style: TextStyle(fontSize: 14.0))),
                                ),  
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('Total Sale', style: TextStyle(fontSize: 14.0))),
                                ), 
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text(widget.price.toString() + " Ks", style: TextStyle(fontSize: 14.0))),
                                ), 
                              ]
                            )
                          ],
                        ),
                      )
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