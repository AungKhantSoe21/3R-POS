import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_text.dart';

class NewMenuScreen extends StatefulWidget {
  const NewMenuScreen({Key? key}) : super(key: key);

  @override
  State<NewMenuScreen> createState() => _NewMenuScreenState();
}

class _NewMenuScreenState extends State<NewMenuScreen> {
  final TextEditingController _menuNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Menu", style: TextStyle(color: Colors.black, fontFamily: poppinFont, fontSize: 16),),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText("Menu Name"),
                  textField("Enter menu name", MediaQuery.of(context).size.width * 0.9, _menuNameController, TextInputType.name, "")
                ],
              ),
            )
          )
        ],
      ),
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