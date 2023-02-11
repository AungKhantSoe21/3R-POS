import 'package:flutter/material.dart';
import 'package:r_pos/core/persistence/user_persistence.dart';
import 'package:r_pos/screens/auth_screens/login_screen.dart';
import 'package:r_pos/screens/home_screen.dart';
import 'package:r_pos/screens/more_screens/ingredient_screen.dart';
import 'package:r_pos/screens/more_screens/invite_member_screen.dart';
import 'package:r_pos/screens/more_screens/profile_screen.dart';
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
          // ignore: prefer_const_constructors
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ProfileScreen())
              );
            },
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.black,),
              title: const Text(
              "Profile",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          if(User.user[1] == "Admin")
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => const InviteMemberScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.group, color: Colors.black,),
              title: Text(
              "Members",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          if(User.user[1] == "Admin")
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => const RoleScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.admin_panel_settings, color: Colors.black,),
              title: Text(
              "Roles",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => const IngredientScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.restaurant_sharp, color: Colors.black,),
              title: Text(
              "Ingredient",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      child: Text("Cancel")
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => const LoginScreen()), (route) {return false;});
                        UserPersistence().removeUserPreference();
                      }, 
                      child: Text("Ok")
                    )
                  ],
                )
              );
            },
            child: const ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black,),
              title: Text(
              "Logout",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}