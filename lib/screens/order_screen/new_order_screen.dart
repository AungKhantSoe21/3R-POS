// ignore_for_file: must_be_immutable
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/screens/order_screen/select_menu.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/drop_down_bottom_modal.dart';
import 'package:r_pos/widgets/toast_message.dart';

class NewOrderScreen extends StatefulWidget {
  List selectedMenu = [];
  NewOrderScreen(this.selectedMenu, {Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  List selectedMenuCard = [];
  String selectedTable = "";
  final TextEditingController chooseTableController = TextEditingController();
  final TextEditingController _ingredient = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref();
    final que = ref.child("Ingredient");
    final tableQue = ref.child("Tables");
    selectedMenuCard = SelectedMenuList.selectedMenuCard;

    return WillPopScope(
      onWillPop: () async {
        SelectedMenuList.selectedMenuCard = [];
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {Navigator.pop(context); SelectedMenuList.selectedMenuCard = [];}, 
            icon: const Icon(Icons.arrow_back, color: Colors.white,)
          ),
          title: const Text("New Order", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25,),
            labelText("Select Table No"),
            InkWell(
              onTap: () async {
                List data = await dropDownBottomModal(
                  context, false, [], tableQue, dropListItemName: "table_no", dropListItemName2: "key", dropListItemName3: "table_status"
                );
                setState(() {
                  if(data.isEmpty) {
                    chooseTableController.text = chooseTableController.text;
                  } else {
                    chooseTableController.text = data[0][0];
                    selectedTable = data[0][1];
                  }
                });
              },
              child: AbsorbPointer(
                child: textField("Select sitting table no", MediaQuery.of(context).size.width * 0.9, chooseTableController, TextInputType.name, "")
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SelectMenuScreen())
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white)
                    ),
                    child: const Text("Select Menu"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Text("Selected Menu", style: TextStyle(fontWeight: FontWeight.bold),),
                      Divider(thickness: 0.5, color: Colors.black,),
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
                                                            child: Center(child: Text("Edit Selected Menu"))
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
                                                                                Text("Edit")
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
                                                                                Text("Delete")
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                        color: Colors.grey,
                                                                        elevation: 2,
                                                                        onSelected: (value) {
                                                                          if(value == 1) {
                                                                            _ingredient.text = data[j]['ingredient'];
                                                                            _description.text = data[j]['description'];
                                                                            showDialog(
                                                                              context: context, 
                                                                              barrierDismissible: false,
                                                                              builder: (context) => AlertDialog(
                                                                                title: const Text("Update", style: TextStyle(fontSize: 12),),
                                                                                content: SizedBox(
                                                                                  height: 200,
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      labelText("Add Ingredient", padding: 10),
                                                                                      InkWell(
                                                                                        onTap: () async {
                                                                                          List data = await dropDownBottomModal(
                                                                                            context, false, [], que, dropListItemName: "ingredient_name"
                                                                                          );
                                                                                          setState(() {
                                                                                            if(data.isEmpty) {
                                                                                              _ingredient.text = _ingredient.text;
                                                                                            } else {
                                                                                              _ingredient.text = data[0][0];
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                        child: AbsorbPointer(
                                                                                          child: textField(
                                                                                            "Add Ingredient", 
                                                                                            double.infinity, 
                                                                                            _ingredient, 
                                                                                            TextInputType.name,
                                                                                            ""
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      labelText("Description", padding: 10),
                                                                                      textField(
                                                                                        "Description", 
                                                                                        double.infinity, 
                                                                                        _description, 
                                                                                        TextInputType.name,                                                                           ""
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: [  
                                                                                    TextButton(onPressed: () {
                                                                                      _ingredient.text = "";
                                                                                      _description.text = "";
                                                                                      Navigator.pop(context);
                                                                                    }, child: const Text("Cancel", style: TextStyle(color: Colors.red),),),  
                                                                                    TextButton(onPressed: () async {
                                                                                      setState(() {
                                                                                        data[j]['ingredient'] = _ingredient.text;
                                                                                        data[j]['description'] = _description.text;
                                                                                      });
                                                                                      _ingredient.text = "";
                                                                                      _description.text = "";
                                                                                      Navigator.pop(context);
                                                                                      toastMessage("Update Successful", txtColor: Colors.green);
                                                                                    }, child: const Text("Update", style: TextStyle(color: Colors.green),),)  
                                                                                ]
                                                                              )
                                                                            );
                                                                          } else {
                                                                            setState(() {
                                                                              Future(() {
                                                                                if(j <= 0 && data.length == 1) {
                                                                                  Navigator.pop(context);
                                                                                }
                                                                              }).then((value) {
                                                                                if(j <= 0 && data.length == 1) {
                                                                                  data = [];
                                                                                  selectedMenuCard[i] = [];
                                                                                  selectedMenuCard.removeAt(i);
                                                                                } else {
                                                                                  data.removeAt(j);
                                                                                }
                                                                              });
                                                                            });
                                                                          }
                                                                        },
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
              ),
            ),
            Center(
              child: SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    await ref.child("Order").push().set({
                      "table_no" : chooseTableController.text,
                      "table_key" : selectedTable,
                      "ordered_menu" : selectedMenuCard,
                      "order_status" : "Confirm",
                      "order_time" : DateTime.now().toString()
                    }).asStream();
                    await ref.child("Tables").child(selectedTable).update({
                      "table_status" : "Unavailable"
                    });
                    Navigator.pop(context);
                    SelectedMenuList.selectedMenuCard = [];
                  }, 
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
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