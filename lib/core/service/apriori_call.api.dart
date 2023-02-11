import 'dart:convert';

import 'package:http/http.dart' as http;

getRules(List tra, String sup, String con) async {
  var uri = Uri.parse('http://192.168.137.213:7777/aprori');
  final response = await http.post(
    uri,
    headers: {
      'Accept': '*/*',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      {
        // "tra": [
        //   {
        //     "tid": "1",
        //     "items": [1, 2, 3, 4]
        //   },
        //   {
        //       "tid": "1",
        //       "items": [1, 2, 4]
        //   },
        //   {
        //       "tid": "1",
        //       "items": [1, 2, 3, 4]
        //   }
        // ],
        "tra" : tra,
        "sup": int.parse(sup),
        "con": int.parse(con)
      }
    ),
  );

  var data = json.decode(response.body);

  ResponseStatusModel responseStatusModel = ResponseStatusModel(
    rule: data["set"],
    confidence: data['cItems']
  );

  return responseStatusModel;
}

class ResponseStatusModel {
  final List rule;
  final List confidence;

  ResponseStatusModel({
    required this.rule,
    required this.confidence,
  });
}

