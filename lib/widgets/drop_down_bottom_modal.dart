import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

dropDownBottomModal(BuildContext context, bool dropDownWithList, List dropDownItems, DatabaseReference ref, {double height = 350, String dropListItemName = ""}) async {
  String _returnString = "";
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
                  _returnString = data;
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
              return SizedBox(
                height: height,
                child: ListView(
                  children: [
                    for (int i = 0; i < dropList.length; i++)
                    InkWell(
                      onTap: () {
                        String data = dropList[i][dropListItemName];
                        _returnString = data;
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
              return SizedBox(
                height: 1,
              );
            }
          }
        );
      }
    } 
  );
  return _returnString;
}
