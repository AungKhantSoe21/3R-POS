import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

Future<List> dropDownBottomModal(BuildContext context, bool dropDownWithList, List dropDownItems, DatabaseReference ref, {double height = 350, String dropListItemName = "", String dropListItemName2 = "", String dropListItemName3 = ""}) async {
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
        return FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, a, i) {
            // if(snapshot.hasData) {
              Map dropList = snapshot.value as Map;
              dropList['key'] = snapshot.key;
              // dropList.toList().sort((a, b) => a[dropListItemName].compareTo(b[dropListItemName]));
              if(dropListItemName3.isNotEmpty && dropList[dropListItemName3] == "Unavailable") {
                return Container();
              }
              return InkWell(
                onTap: () {
                  if(dropListItemName2.isNotEmpty) {
                    returnList.add([dropList[dropListItemName], dropList[dropListItemName2]]);
                  } else {
                    returnList.add([dropList[dropListItemName]]);
                  }
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text(
                    dropList[dropListItemName],
                    style: const TextStyle(fontSize: 12,),
                  ),
                ),
              );
            // } else {
            //   return const SizedBox(
            //     height: 1,
            //   );
            // }
          }
        );
      }
    } 
  );
  return returnList;
}
