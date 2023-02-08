import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/toast_message.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final TextEditingController _roleName = TextEditingController();

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
          "Roles",
          style: TextStyle(
              fontFamily: poppinFont, fontSize: 16, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text(
                "New Role",
                style: TextStyle(fontSize: 12),
              ),
              content: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText("Role Name", padding: 10),
                    textField("Enter role name", double.infinity, _roleName, TextInputType.name, "")
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _roleName.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    ref
                        .child("Role")
                        .push()
                        .set({"role_name": _roleName.text}).asStream();
                    _roleName.text = "";
                    Navigator.pop(context);
                    toastMessage("Role created", txtColor: Colors.green);
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
          size: 18,
        ),
      ),
      body: FirebaseAnimatedList(
        query: ref.child("Role"), 
        itemBuilder: (context, snapshot, a, i) {
          Map mydata = snapshot.value as Map;
          mydata['key'] = snapshot.key;
          return ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: Text(mydata['role_name']),
            trailing: IconButton(
              onPressed: () {
                ref.child("Role").child(mydata['key']).remove();
              }, 
              icon: const Icon(Icons.delete, color: Colors.red,)
            ),
          );
        }
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
      String error) {
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
