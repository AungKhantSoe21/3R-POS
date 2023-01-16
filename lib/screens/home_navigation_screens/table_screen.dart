import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List tableList = [
    ['1', "1", "10"],
    ['2', "2", "5"],
    ['3', "2", "4"],
    ['4', "3", "3"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: tableList.length + 1,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        itemBuilder: (BuildContext context, int index) {
          if(index == tableList.length) {
            return Container(
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 50,),
                  SizedBox(height: 5,),
                  Text("New Table")
                ],
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
                  textRow("No", tableList[index][0]),
                  textRow(
                    "Shape", 
                    tableList[index][1], 
                    iconOn: true, 
                    icon: tableList[index][1] == "1" 
                    ? Icons.rectangle_outlined
                    : tableList[index][1] == "2" 
                    ? Icons.circle_outlined
                    : Icons.square_outlined
                  ),
                  textRow("Capable", tableList[index][2]),
                ],
              ),
            );
          }
        },
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
