import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/screens/table_screens/new_table_screen.dart';
import 'package:r_pos/utils/constant_color.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child("Tables");

    return Scaffold(
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            final map = snapshot.data.snapshot.value;
            List tables = map.values.toList();
            tables.sort((a, b) => a['table_no'].compareTo(b['table_no']));
            return GridView.builder(
              itemCount: tables.length + 1,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemBuilder: (BuildContext context, int index) {
                if(index == tables.length) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => NewTableScreen())
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 50, color: Colors.white,),
                          SizedBox(height: 5,),
                          Text("New Table", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textRow("No", tables[index]['table_no']),
                        textRow(
                          "Shape", 
                          tables[index]['table_shape'], 
                          iconOn: true, 
                          icon: tables[index]['table_shape'] == "Rectangle" 
                          ? Icons.rectangle_outlined
                          : tables[index]['table_shape'] == "Circle" 
                          ? Icons.circle_outlined
                          : Icons.square_outlined
                        ),
                        textRow("Capable", tables[index]['customer_capacity'].toString()),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        }
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
            child: Text(text1),
          ),
        ),
        SizedBox(width: 8, child: Text(":")),
        if(!iconOn)
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Text(
            "$text2",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: text2Color),
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
