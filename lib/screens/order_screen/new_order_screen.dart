import 'package:flutter/material.dart';
import 'package:r_pos/screens/order_screen/select_menu.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';

class NewOrderScreen extends StatefulWidget {
  final List selectedMenu;
  const NewOrderScreen(this.selectedMenu, {Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final TextEditingController chooseTableController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
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
          textField("Select sitting table no", MediaQuery.of(context).size.width * 0.9, chooseTableController, TextInputType.name, ""),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
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
                  children: const [
                    SizedBox(height: 5,),
                    Text("Selected Menu", style: TextStyle(fontWeight: FontWeight.bold),),
                    Divider(thickness: 0.5, color: Colors.black,)
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
                onPressed: () {}, 
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
    );
  }

  Widget labelText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 5),
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