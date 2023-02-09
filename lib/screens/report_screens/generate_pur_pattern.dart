import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/screens/report_screens/generated_result.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';

class GenerateItemPurchasing extends StatefulWidget {
  const GenerateItemPurchasing({Key? key}) : super(key: key);

  @override
  State<GenerateItemPurchasing> createState() => _GenerateItemPurchasingState();
}

class _GenerateItemPurchasingState extends State<GenerateItemPurchasing> {
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
        title: const Text("Generate Purchasing Patterns", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          labelText("Minimum Support Count"),
          textField("Enter minimum support count", MediaQuery.of(context).size.width * 0.85, _tableNo, TextInputType.number, ""),
          const SizedBox(height: 5,),
          labelText("Minimum Confidence (%)"),
          textField("Enter minimum confidence", MediaQuery.of(context).size.width * 0.85, _cusCapacity, TextInputType.number, ""),const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText("From", leftPadding: 5),
                  textField("From Date", MediaQuery.of(context).size.width * 0.40, _cusCapacity, TextInputType.number, "", length: false),const SizedBox(height: 5,),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText("To", leftPadding: 5),
                  textField("To Date", MediaQuery.of(context).size.width * 0.40, _cusCapacity, TextInputType.number, "", length: false),const SizedBox(height: 5,),
                ],
              ),
            ],
          ),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => GeneratedResult())
                  );
                }, 
                child: const Text("Generate")
              ),
            ),
          )
        ],
      )
    );
  }

  Widget labelText(String text, {double leftPadding = 35.0}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, bottom: 5),
      child: Text(
        text,
      ),
    );
  }

  Widget textField(String hintText, double width, TextEditingController controller, TextInputType textInputType, String error, {bool length = true}) {
    return Center(
      child: SizedBox(
        width: width,
        child: TextField(
          maxLength: length ? 2 : null,
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