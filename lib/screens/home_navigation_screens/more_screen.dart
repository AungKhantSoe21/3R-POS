import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Colors.black,),
            title: Text(
            "Profile",
              style: const TextStyle(fontSize: 13),
            ),
          ),
          ListTile(
            leading: Icon(Icons.group_add, color: Colors.black,),
            title: Text(
            "Invite new member",
              style: const TextStyle(fontSize: 13),
            ),
          ),
          ListTile(
            leading: Icon(Icons.group, color: Colors.black,),
            title: Text(
            "Members",
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}