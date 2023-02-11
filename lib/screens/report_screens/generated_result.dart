import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:r_pos/core/service/apriori_call.api.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/loader.dart';

class GeneratedResult extends StatefulWidget {
  String supportCount = "";
  String minimumConf = "";
  List transaction = [];
  GeneratedResult(this.supportCount, this.minimumConf, this.transaction, {Key? key}) : super(key: key);

  @override
  State<GeneratedResult> createState() => _GeneratedResultState();
}

class _GeneratedResultState extends State<GeneratedResult> {
  ResponseStatusModel? res;
  bool isLoading = false;

  List rules = [];
  List set = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    res = await getRules(widget.transaction, widget.supportCount, widget.minimumConf);
    setState(() {
      isLoading = false;
    });
    rules = res!.confidence;
    set = res!.rule[0]["name"];
  }

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
            child: textRow("Min Supp-Count", widget.supportCount),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: textRow("Min Confidence", widget.minimumConf + "%"),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: textRow("Rule", isLoading ? "Callculating..." : res!.rule[0]['name'].toString()),
          ),
          SizedBox(height: 10,),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
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
                            Text(widget.transaction[i]["tid"].toString())
                          ],
                        ),
                        Row(
                          children: [
                            Text("Transaction   :   "),
                            Text(widget.transaction[i]["items"].toString())
                          ],
                        )
                      ]
                    ),
                  );
                }, 
                separatorBuilder: (context, i) {
                  return SizedBox(
                    height: 6,
                  );
                }, 
                itemCount: widget.transaction.length
              ),
            ),
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
                child: isLoading ? Loader(primaryColor, 2, size: 20) : SingleChildScrollView(
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
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ruleRow(int i) {
    List p = [];
    p = res!.rule[0]["name"];
    List data = rules[i][0].toString().split(",");
    log(data.toString());
    for (int j = 0; j < data.length; j++) {
      p.remove(data[j].toString());
    }
    log(p.toString());
    if(set.length != data.length) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            Text(rules[i][0]),
            Icon(Icons.arrow_forward),
            // Text(p.toString()),
            // SizedBox(width: 10,),
            // Icon(Icons.arrow_forward),
            Text(rules[i][1]),
          ],
        ),
      );
    }
    return Container();
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