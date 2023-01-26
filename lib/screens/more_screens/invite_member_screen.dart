import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/screens/more_screens/new_member_screen.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';

class InviteMemberScreen extends StatefulWidget {
  const InviteMemberScreen({Key? key}) : super(key: key);

  @override
  State<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Members",
          style: TextStyle(fontFamily: poppinFont, fontSize: 16, color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) => NewMemberScreen()));
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.person_add,
          color: Colors.black,
          size: 18,
        ),
      ),
      body: FirebaseAnimatedList(
        query: ref.child("User"), 
        itemBuilder: (context, snapshot, a, i) {
          Map mydata = snapshot.value as Map;
          mydata['key'] = snapshot.key;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Name  :   " + mydata['user_name']),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                            onPressed: () {}, 
                            icon: Icon(Icons.edit, color: Colors.greenAccent, size: 20,)
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Role      :   " + mydata['user_role']),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                            onPressed: () {
                              ref.child("User").child(mydata['key']).remove();
                            }, 
                            icon: Icon(Icons.delete, color: Colors.red, size: 20,)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
          );
        }
      ),
    );
  }
}