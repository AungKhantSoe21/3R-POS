import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 15,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shadowColor: Colors.transparent,
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                child: Text("View Sale Reports", style: TextStyle(color: Colors.black),),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shadowColor: Colors.transparent,
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                child: Text("Generate Item Purchasing Patterns", style: TextStyle(color: Colors.black),),
              ),
            ),
          ),
          SizedBox(height: 25,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                border: Border.fromBorderSide(
                  BorderSide(color: Colors.black)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text("Sale Report (Today)", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 10,),
                  Divider(thickness: 1, color: Colors.black,),
                  Expanded(
                    child: SizedBox(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Table(
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide())
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Center(child: Text('Date', style: TextStyle(fontSize: 14.0))),
                                ),  
                                Center(child: Text('Time', style: TextStyle(fontSize: 14.0))),  
                                Center(child: Text('Qty', style: TextStyle(fontSize: 14.0))), 
                                Center(child: Text('Net Amount', style: TextStyle(fontSize: 14.0))), 
                              ]
                            ),
                            for(int i = 0; i < 20; i++)
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('12/12/2023', style: TextStyle(fontSize: 14.0))),
                                ),  
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('12:00PM', style: TextStyle(fontSize: 14.0))),
                                ),  
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('12', style: TextStyle(fontSize: 14.0))),
                                ), 
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('100000 Ks', style: TextStyle(fontSize: 14.0))),
                                ), 
                              ]
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('', style: TextStyle(fontSize: 14.0))),
                                ),  
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('Total Sale =>', style: TextStyle(fontSize: 14.0))),
                                ),  
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('1000', style: TextStyle(fontSize: 14.0))),
                                ), 
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(child: Text('1000000 Ks', style: TextStyle(fontSize: 14.0))),
                                ), 
                              ]
                            )
                          ],
                        ),
                      )
                    )
                  ) 
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}