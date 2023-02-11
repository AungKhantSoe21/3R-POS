import 'package:flutter/material.dart';
import 'package:r_pos/screens/home_screen.dart';
import 'package:r_pos/utils/constant_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {Navigator.pop(context);}, 
            icon: const Icon(Icons.arrow_back, color: Colors.white,)
          ),
          title: const Text("Profile", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
          centerTitle: true,
        ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 49,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage((User.user[1] == "Admin" ? "assets/images/admin.png" : User.user[1] == "Cashier" ? "assets/images/cashier.png" : "assets/images/waiter.png")),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Center(child: Text("User Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                    SizedBox(height: 30,),
                    textRow("Name", User.user[0]),
                    SizedBox(height: 15,),
                    textRow("Role", User.user[1]),
                  ],
                ),
              ),
            ),
          )
        ]
      ),
    );
  }

  Widget textRow(String text1, String text2, {bool iconOn = false, IconData icon = Icons.circle, Color text2Color = Colors.black}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(text1, style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ),
        const SizedBox(width: 8, child: Text(":")),
        if(!iconOn)
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              text2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: text2Color),
            ),
          ),
        )
        else
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
          child: Icon(icon),
        )
      ],
    );
  }
}