import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/drop_down_bottom_modal.dart';

class NewTableScreen extends StatefulWidget {
  const NewTableScreen({Key? key}) : super(key: key);

  @override
  State<NewTableScreen> createState() => _NewTableScreenState();
}

class _NewTableScreenState extends State<NewTableScreen> {
  final TextEditingController _tableNo = TextEditingController();
  final TextEditingController _cusCapacity = TextEditingController();
  final TextEditingController _tableShape = TextEditingController();

  final database = FirebaseDatabase.instance;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ref = database.ref();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: const Text("New Table", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          labelText("Table No"),
          textField("Enter table no", MediaQuery.of(context).size.width * 0.85, _tableNo, TextInputType.name, ""),
          const SizedBox(height: 5,),
          labelText("Customer Capacity"),
          textField("Enter capable customer quantity", MediaQuery.of(context).size.width * 0.85, _cusCapacity, TextInputType.number, ""),
          const SizedBox(height: 5,),
          labelText("Table Shape"),
          InkWell(
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              List tableShape = ["Circle", "Rectangle", "Square"];
              var data = await dropDownBottomModal(context, true, tableShape, ref);
              
              setState(() {
                if(data.isEmpty) {
                  _tableShape.text = _tableShape.text;
                } else {
                  _tableShape.text = data[0][0];
                }
              });
            },
            child: AbsorbPointer(
              child: textField("Choose table shape", MediaQuery.of(context).size.width * 0.85, _tableShape, TextInputType.name, "")
            ),
          ),
          const SizedBox(height: 5,),
          Center(
            child: SizedBox(
              width: 100,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () async {
                  ref.child("Tables").push().set({
                    "table_no" : _tableNo.text,
                    "customer_capacity" : int.parse(_cusCapacity.text),
                    "table_shape" : _tableShape.text,
                    "table_status" : "Available"
                  }).asStream();
                  Navigator.pop(context);
                }, 
                child: const Text("Create")
              ),
            ),
          )
        ],
      )
    );
  }

  Widget labelText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, bottom: 5),
      child: Text(
        text,
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