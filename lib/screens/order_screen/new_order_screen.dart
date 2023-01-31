import 'package:flutter/material.dart';
import 'package:r_pos/screens/order_screen/select_menu.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';

class NewOrderScreen extends StatefulWidget {
  final List selectedMenu;
  NewOrderScreen(this.selectedMenu, {Key? key}) : super(key: key);

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
          icon: Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: Text("New Order", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25,),
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
                      MaterialPageRoute(builder: (_) => SelectMenuScreen())
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  child: Text("Select Menu"),
                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
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
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                )
              ),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  Widget labelText(String _text) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 5),
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