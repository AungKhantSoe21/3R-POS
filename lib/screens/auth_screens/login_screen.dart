import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/core/persistence/user_persistence.dart';
import 'package:r_pos/screens/home_screen.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/widgets/text_field_widget.dart';
import 'package:r_pos/widgets/toast_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref();
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if(isKeyboard)
            SizedBox(height: 15),
            if(!isKeyboard)
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                radius: 54,
              ),
            ),
            SizedBox(height: 15,),
            Center(child: Text("Sign In", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: textField(nameController, "", hintText: "Enter username"),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: textField(passwordController, "", hintText: "Enter password"),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              width: 100,
              height: 35,
              child: ElevatedButton(
                onPressed: () async {
                  Stream<DatabaseEvent> stream = ref.child("User").onValue;

                  stream.listen((DatabaseEvent event) {
                    final map = event.snapshot.value as Map;
                    List data = map.values.toList();
                    bool isUser = false;
                    for(int i = 0; i < data.length; i++) {
                      if(data[i]['user_name'] == nameController.text && data[i]['user_password'] == passwordController.text) {
                        UserPersistence().saveUserPersistence(data[i]['user_name'], data[i]['user_role']);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => HomeScreen())
                        );
                        isUser = true;
                      } else if(isUser == false && i == data.length - 1) {
                        toastMessage("User not found!");
                      }
                    } 
                  });
                }, 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  shadowColor: MaterialStateProperty.all(Colors.transparent)
                ),
                child: Text("Login", style: TextStyle(fontSize: 14, color: Colors.black),)
              ),
            )
          ]
        ),
      ),
    );
  }

  
}