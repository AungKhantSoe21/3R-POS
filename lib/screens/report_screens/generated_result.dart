import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_text.dart';

class GeneratedResult extends StatefulWidget {
  const GeneratedResult({Key? key}) : super(key: key);

  @override
  State<GeneratedResult> createState() => _GeneratedResultState();
}

class _GeneratedResultState extends State<GeneratedResult> {
  List rules = [
    {
      "front": "Alcohol, Beer, Water",
      "back": "French Fries",
      "confidence": "86%"
    },
    {
      "front": "Alcohol, Beer, Ice",
      "back": "Water",
      "confidence": "100%"
    },
    {
      "front": "Alcohol, Ice, Water",
      "back": "French Fries",
      "confidence": "75%"
    },
    {
      "front": "Alcohol, Ice, Water",
      "back": "Salad",
      "confidence": "75%"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: const Text("Generated Result", style: TextStyle(color: Colors.white, fontFamily: poppinFont, fontSize: 16),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: textRow("Min Supp-Count", "4"),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: textRow("Min Confidence", "70%"),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: textRow("From Date", "1-2-2023"),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: textRow("To Date", "9-2-2023"),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Association Rules", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    for(int i = 0; i < rules.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ruleRow(i),
                    )
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ruleRow(int i) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text(rules[i]['front']),
          Icon(Icons.arrow_forward),
          Text(rules[i]['back']),
          SizedBox(width: 10,),
          Icon(Icons.arrow_forward),
          Text(rules[i]['confidence']),
        ],
      ),
    );
  }

  Widget textRow(String text1, String text2,
      {Color text2Color = Colors.black}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: Text(text1)),
        ),
        SizedBox(width: 15, child: Text(":")),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Text(text2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: text2Color)))
      ],
    );
  }
}