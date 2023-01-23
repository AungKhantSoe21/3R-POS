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
        title: Text("New Table", style: TextStyle(color: Colors.black, fontFamily: poppinFont, fontSize: 16),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25,),
          labelText("Table No"),
          textField("Enter table no", MediaQuery.of(context).size.width * 0.85, _tableNo, TextInputType.name, ""),
          SizedBox(height: 5,),
          labelText("Customer Capacity"),
          textField("Enter capable customer quantity", MediaQuery.of(context).size.width * 0.85, _cusCapacity, TextInputType.number, ""),
          SizedBox(height: 5,),
          labelText("Table Shape"),
          InkWell(
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              List tableShape = ["Circle", "Rectangle", "Square"];
              var data = await dropDownBottomModal(context, true, tableShape, ref);
              
              setState(() {
                if(data == "") {
                  _tableShape.text = _tableShape.text;
                } else {
                  _tableShape.text = data;
                }
              });
            },
            child: AbsorbPointer(
              child: textField("Choose table shape", MediaQuery.of(context).size.width * 0.85, _tableShape, TextInputType.name, "")
            ),
          ),
          SizedBox(height: 5,),
          Center(
            child: SizedBox(
              width: 100,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.black)
                ),
                onPressed: () async {
                  await ref.child("Tables").push().set({
                    "table_no" : _tableNo.text,
                    "customer_capacity" : int.parse(_cusCapacity.text),
                    "table_shape" : _tableShape.text
                  }).asStream();
                  Navigator.pop(context);
                }, 
                child: Text("Create")
              ),
            ),
          )
        ],
      )
    );
  }

  Widget labelText(String _text) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, bottom: 5),
      child: Text(
        _text,
      ),
    );
  }

  Widget textField(String _hintText, double _width, TextEditingController _controller, TextInputType _textInputType, String _error) {
    return Center(
      child: SizedBox(
        width: _width,
        child: TextField(
          controller: _controller,
          keyboardType: _textInputType,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            // error text for textfield
            errorText: _error,
            hintText: _hintText,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)
            ),
            errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}