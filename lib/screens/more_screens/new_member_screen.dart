// ignore_for_file: use_build_context_synchronously

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/drop_down_bottom_modal.dart';

class NewMemberScreen extends StatefulWidget {
  const NewMemberScreen({Key? key}) : super(key: key);

  @override
  State<NewMemberScreen> createState() => _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
  final TextEditingController _memberNameController = TextEditingController();
  final TextEditingController _memberPasswordController =
      TextEditingController();
  final TextEditingController _memberRoleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: const Text(
          "Add Member",
          style: TextStyle(
              fontFamily: poppinFont, fontSize: 16, color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          labelText("Name"),
          textField(
            "Enter new member name",
            MediaQuery.of(context).size.width * 0.9,
            _memberNameController,
            TextInputType.name,
            "",
          ),
          labelText("Password"),
          textField(
            "Enter password for new member",
            MediaQuery.of(context).size.width * 0.9,
            _memberPasswordController,
            TextInputType.name,
            "",
            password: true,
          ),
          labelText("Role"),
          InkWell(
            onTap: () async {
              String data = await dropDownBottomModal(context, false, [], ref.child("Role"), dropListItemName: "role_name");
              setState(() {
                if (data.isEmpty) {
                  _memberRoleController.text = _memberRoleController.text;
                } else {
                  _memberRoleController.text = data;
                }
              });
            },
            child: AbsorbPointer(
              child: textField(
                "Set role for new member",
                MediaQuery.of(context).size.width * 0.9,
                _memberRoleController,
                TextInputType.name,
                "",
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () async {
                  await ref.child("User").push().set({
                    "user_name": _memberNameController.text,
                    "user_password": _memberPasswordController.text,
                    "user_role": _memberRoleController.text,
                    "user_email": "",
                    "user_phone": "",
                    "user_address": "",
                  });
                  Navigator.pop(context);
                },
                child: const Text("Create", style: TextStyle(color: Colors.white),),
              ),
            ),
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
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget textField(
      String hintText,
      double width,
      TextEditingController controller,
      TextInputType textInputType,
      String error,
      {bool password = false}) {
    return Center(
      child: SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          cursorColor: Colors.black,
          obscureText: password,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            // error text for textfield
            errorText: error,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 12),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10)),
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
