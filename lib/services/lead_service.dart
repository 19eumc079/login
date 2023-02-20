import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

Future getData(String contactId, int limit, String lastId, String token) async {
  final response = await http.get(
    Uri.parse(
        'https://api.cargoez.dev/leadserver/api/v1/portal/leads/paginate/$contactId/$limit/$lastId?form={}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );
  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    var value = responseData['data'];

    // Use the value in your app

    var data = value.firstWhere((e) => e["fileNumber"]);

    print(data);
  } else {
    print('aaaaaaaaaaaaaaa');
  }
}
