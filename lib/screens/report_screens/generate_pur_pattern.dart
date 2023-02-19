import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/screens/report_screens/generated_result.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';

class GenerateItemPurchasing extends StatefulWidget {
  const GenerateItemPurchasing({Key? key}) : super(key: key);

  @override
  State<GenerateItemPurchasing> createState() => _GenerateItemPurchasingState();
}

class _GenerateItemPurchasingState extends State<GenerateItemPurchasing> {
  final TextEditingController _minimumSupport = TextEditingController();
  final TextEditingController _minimumConf = TextEditingController();
  // final TextEditingController _transaction = TextEditingController();
  List dataTransaction = [
    {
      "tid": "T01",
      "items": ["I12","I22","I01","I21","I31","I18","I08","I03","I05"]
    },
    {
      "tid": "T02",
      "items": ["I16","I22","I32","I13","I01","I06","I31","I23","I18","I24"]
    },
    {
      "tid": "T03",
      "items": ["I27","I10","I08","I03"]
    },
    {
      "tid": "T04",
      "items": ["I05","I03","I14","I04","I17","I20","I31","I07"]
    },
    {
      "tid": "T05",
      "items": ["I01","I23","I07","I31","I18","I10","I22","I14","I19"]
    },
    {
      "tid": "T06",
      "items": ["I01","I06","I14","I09","I02","I15","I08","I31"]
    },
    // {
    //   "tid": "T07",
    //   "items": ["I03","I01","I30","I11","I05","I31","I18","I10","I28"]
    // },
    // {
    //   "tid": "T08",
    //   "items": ["I02","I06","I03","I29","I25","I26","I31","I20"]
    // },
    // {
    //   "tid": "T09",
    //   "items": ["I10","I22","I01","I21","I31","I18","I08","I03","I05"]
    // },
    // {
    //   "tid": "T10",
    //   "items": ["I32","I01","I23","I24","I31","I18","I06","I22","I03","I10"]
    // },
    // {
    //   "tid": "T11",
    //   "items": ["I12","I16","I21","I01","I31","I08","I18","I10","I03"]
    // },
    // {
    //   "tid": "T12",
    //   "items": ["I26","I25","I31","I03","I06","I10","I05","I02"]
    // },
    // {
    //   "tid": "T13",
    //   "items": ["I11","I30","I01","I03","I05","I31","I10"]
    // },
    // {
    //   "tid": "T14",
    //   "items": ["I01","I13","I31","I18","I23","I10","I22","I03"]
    // },
    // {
    //   "tid": "T15",
    //   "items": ["I17","I13","I12","I21","I03","I10","I06"]
    // },
  ];

  final database = FirebaseDatabase.instance;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // final ref = database.ref();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: const Text("Generate Purchasing Patterns", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          labelText("Minimum Support Count"),
          textField("Enter minimum support count", MediaQuery.of(context).size.width * 0.85, _minimumSupport, TextInputType.number, ""),
          const SizedBox(height: 5,),
          labelText("Minimum Confidence (%)"),
          textField("Enter minimum confidence", MediaQuery.of(context).size.width * 0.85, _minimumConf, TextInputType.number, ""),const SizedBox(height: 5,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         labelText("From", leftPadding: 5),
          //         textField("From Date", MediaQuery.of(context).size.width * 0.40, _cusCapacity, TextInputType.number, "", length: false),const SizedBox(height: 5,),
          //       ],
          //     ),
          //     SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         labelText("To", leftPadding: 5),
          //         textField("To Date", MediaQuery.of(context).size.width * 0.40, _cusCapacity, TextInputType.number, "", length: false),const SizedBox(height: 5,),
          //       ],
          //     ),
          //   ],
          // ),
          // labelText("Enter transaction (e.g: 1,2,3,4)"),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //   child: Row(
          //     children: [
          //       textField("Enter transaction (e.g: 1,2,3,4)", MediaQuery.of(context).size.width * 0.65, _transaction, TextInputType.name, "", length: false),
          //       SizedBox(width: 10,),
          //       Padding(
          //         padding: const EdgeInsets.only(bottom: 25.0),
          //         child: SizedBox(
          //           height: 45,
          //           width: MediaQuery.of(context).size.width * 0.17,
          //           child: ElevatedButton(
          //             style: ButtonStyle(
          //               backgroundColor: MaterialStateProperty.all(primaryColor)
          //             ),
          //             onPressed: () {
          //               FocusScope.of(context).requestFocus(FocusNode());
          //               setState(() {
          //                 dataTransaction.add({
          //                   "tid" : dataTransaction.length +1,
          //                   "items" : _transaction.text
          //                 });
          //               });
          //             }, 
          //             child: Text("Add")
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          const SizedBox(height: 5,),
          Center(
            child: SizedBox(
              width: 100,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => GeneratedResult(
                      _minimumSupport.text, _minimumConf.text, dataTransaction
                    ))
                  );
                }, 
                child: const Text("Generate")
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, i) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("TID   :   "),
                              Text(dataTransaction[i]["tid"].toString())
                            ],
                          ),
                          Row(
                            children: [
                              Text("Transaction   :   "),
                              Text(dataTransaction[i]["items"].toString())
                            ],
                          )
                        ]
                      ),
                    );
                  }, 
                  separatorBuilder: (context, i) {
                    return SizedBox(
                      height: 8,
                    );
                  }, 
                  itemCount: dataTransaction.length
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  Widget labelText(String text, {double leftPadding = 35.0}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, bottom: 5),
      child: Text(
        text,
      ),
    );
  }

  Widget textField(String hintText, double width, TextEditingController controller, TextInputType textInputType, String error, {bool length = true}) {
    return Center(
      child: SizedBox(
        width: width,
        child: TextField(
          maxLength: length ? 2 : null,
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
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)
            ),
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