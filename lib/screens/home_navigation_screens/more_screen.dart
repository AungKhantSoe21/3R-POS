import 'package:flutter/material.dart';
import 'package:r_pos/core/persistence/user_persistence.dart';
import 'package:r_pos/screens/auth_screens/login_screen.dart';
import 'package:r_pos/screens/more_screens/invite_member_screen.dart';
import 'package:r_pos/screens/more_screens/role_screen.dart';

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
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => InviteMemberScreen()));
            },
            child: ListTile(
              leading: Icon(Icons.group, color: Colors.black,),
              title: Text(
              "Members",
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => RoleScreen()));
            },
            child: ListTile(
              leading: Icon(Icons.admin_panel_settings, color: Colors.black,),
              title: Text(
              "Roles",
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => LoginScreen()), (route) {return false;});
              UserPersistence().removeUserPreference();
            },
            child: ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black,),
              title: Text(
              "Logout",
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}