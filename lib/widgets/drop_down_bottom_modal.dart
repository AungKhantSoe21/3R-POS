import 'package:flutter/material.dart';

dropDownBottomModal(BuildContext context, List dropDownItems, {double height = 350}) async {
  String _returnString = "";
  await showModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
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
    ),
  );
  return _returnString;
}
