import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<List> dropDownBottomModal(BuildContext context, bool dropDownWithList, List dropDownItems, DatabaseReference ref, {double height = 350, String dropListItemName = "", String dropListItemName2 = ""}) async {
  List returnList = [];
  await showModalBottomSheet(
    context: context,
    builder: (context) {
      if(dropDownWithList) {
        return SizedBox(
          height: height,
          child: ListView(
            children: [
              for (int i = 0; i < dropDownItems.length; i++)
              InkWell(
                onTap: () {
                  String data = dropDownItems[i];
                  returnList.add([data]);
                  log(returnList.toString());
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text(
                    dropDownItems[i],
                    style: const TextStyle(fontSize: 12,),
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        return StreamBuilder(
          stream: ref.onValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              final map = snapshot.data.snapshot.value;
              List dropList = map.values.toList();
              dropList.sort((a, b) => a[dropListItemName].compareTo(b[dropListItemName]));
              return SizedBox(
                height: height,
                child: ListView(
                  children: [
                    for (int i = 0; i < dropList.length; i++)
                    InkWell(
                      onTap: () {
                        if(dropListItemName2.isNotEmpty) {
                          returnList.add([dropList[i][dropListItemName], dropList[i][dropListItemName2]]);
                        } else {
                          returnList.add([dropList[i][dropListItemName]]);
                        }
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        title: Text(
                          dropList[i][dropListItemName],
                          style: const TextStyle(fontSize: 12,),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox(
                height: 1,
              );
            }
          }
        );
      }
    } 
  );
  return returnList;
}
