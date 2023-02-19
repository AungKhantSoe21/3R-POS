// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:r_pos/screens/order_screen/edit_order_screen.dart';
import 'package:r_pos/screens/order_screen/print_receipt_screen.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';

class OrderDetailScreen extends StatefulWidget {
  List data = [];
  String tableNo = "";
  String time = "";
  String status = "";
  String keyId = "";
  String route = "";
  String date = "";
  String tableKey = "";
  int price = 0;
  OrderDetailScreen(this.data, this.tableNo, this.time, this.status, this.keyId, this.route, this.date, this.tableKey, this.price, {Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List selectedMenuCard = [];

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < widget.data.length; i++) {
      selectedMenuCard.add({
        "key" : widget.data[i]["key"],
        "data" : widget.data[i]["data"],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.route != "order" ? null : FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => EditOrderScreen(widget.data, widget.status, widget.keyId, widget.tableKey))
          );
        }, 
        child: Text("Edit",),
      ),
      
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: Text(widget.route != "order" ? "Sale Detail" : "Order Detail", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PrintReceiptScreen(
                  widget.tableNo,
                  widget.date,
                  widget.time,
                  widget.data,
                  widget.price
                ))
              );
            }, 
            icon: Icon(Icons.assignment, color: Colors.white,)
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Table No : ${widget.tableNo}"),
                      Text("Time : ${widget.time}"),
                      Text("Status : ${widget.status}")
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.09),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Date : ${widget.date}")
                    ),
                  ),
                ],
              )
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 10, top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Text("Ordered Menu", style: TextStyle(fontWeight: FontWeight.bold),),
                    Divider(color: Colors.black,),
                    Expanded(
                      child: SizedBox(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 6.5/9
                          ),   
                          itemBuilder: (context, i) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          List newData = selectedMenuCard[i]['data'];
                                          await showModalBottomSheet(
                                            context: context, 
                                            builder: (context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  List data = newData;
                                                  return SizedBox(
                                                    height: 400,
                                                    width: 300,
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 35,
                                                          child: Center(child: Text("Menu Detail"))
                                                        ),
                                                        Expanded(
                                                          child: data.isEmpty ? Container() : ListView.separated(
                                                            physics: const BouncingScrollPhysics(),
                                                            itemBuilder: (context, j) {
                                                              return SizedBox(
                                                                width: 200,
                                                                height: 60,
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(width: 10,),
                                                                    Container(
                                                                      width: 60,
                                                                      height: 60,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        border: Border.all(),
                                                                        image: DecorationImage(
                                                                          image: NetworkImage(
                                                                            data[j]['image'].toString() == "null" || data[j]['image'].isEmpty == true
                                                                            ? "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/defaultImage%2Ffood.jpg?alt=media&token=5d34f868-8500-4062-a6f9-2e223ea7eb2f"
                                                                            : data[j]['image']
                                                                          ),
                                                                          fit: BoxFit.cover
                                                                        )
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: SizedBox(
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                                                                                  child: SizedBox(
                                                                                    width: 100,
                                                                                    child: Text(data[j]['name'], maxLines: 1, overflow: TextOverflow.ellipsis,)
                                                                                  ),
                                                                                  ),
                                                                                  const Text(" | "),
                                                                                  Expanded(
                                                                                    child: SizedBox(
                                                                                      child: Text(data[j]['ingredient'].isEmpty ? "No Ingredient" : data[j]['ingredient'], maxLines: 1, overflow: TextOverflow.ellipsis,)
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                                                                                    child: SizedBox(
                                                                                      width: 100,
                                                                                      child: Text(data[j]['price'] + " Ks", maxLines: 1, overflow: TextOverflow.ellipsis,)
                                                                                    ),
                                                                                  ),
                                                                                  const Text(" | "),
                                                                                  Expanded(
                                                                                    child: SizedBox(
                                                                                      child: Text(data[j]['description'].isEmpty ? "No Description" : data[j]['description'], maxLines: 1, overflow: TextOverflow.ellipsis,)
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              )
                                                                            ]
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(width: 10,)
                                                                    ],
                                                                  ),
                                                                );
                                                              }, 
                                                              separatorBuilder: (context, index) {
                                                                return const SizedBox(
                                                                  height: 10,
                                                                );
                                                              }, 
                                                              itemCount: data.length
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                            child: Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 20.0, bottom: 5),
                                                                child: ElevatedButton(
                                                                  style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all(primaryColor)
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  }, 
                                                                  child: const Text("OK")
                                                                ),
                                                              )
                                                            )
                                                          ),
                                                        ],
                                                      )
                                                    );
                                                  }
                                                );
                                              }
                                            ).then((value) => setState(() { }));
                                          },
                                          child: Container(
                                            width: double.infinity - 10,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(),
                                              borderRadius: BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: selectedMenuCard[i]['data'][0]['image'].toString() == "null" || selectedMenuCard[i]['data'][0]['image'].isEmpty == true
                                                      ? const NetworkImage("https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/defaultImage%2Ffood.jpg?alt=media&token=5d34f868-8500-4062-a6f9-2e223ea7eb2f")
                                                      : NetworkImage(selectedMenuCard[i]['data'][0]['image']),
                                                fit: BoxFit.cover
                                              )
                                            ),
                                          ),
                                        ),
                                        SizedBox( 
                                          width: double.infinity - 10,
                                          child: Text(
                                            selectedMenuCard[i]['data'][0]['name'], 
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 10,color: Colors.black),
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 1,
                                    child: CircleAvatar(
                                      radius: 10.5,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child: Center(child: Text(selectedMenuCard[i]['data'].length.toString(), style: const TextStyle(fontSize: 10)))
                                      ),
                                    )
                                  )
                                ],
                              );
                            },
                            itemCount: selectedMenuCard.length,
                        ),
                      )
                    )
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget labelText(String text, {double padding = 30}) {
    return Padding(
      padding: EdgeInsets.only(left: padding, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12
        ),
      ),
    );
  }

  Widget textField(String hintText, double width, TextEditingController controller, TextInputType textInputType, String error) {
    return Center(
      child: SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            // error text for textfield
            errorText: error,
            hintText: hintText,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)
            ),
            errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}