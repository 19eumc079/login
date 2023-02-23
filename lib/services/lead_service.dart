import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

List<dynamic> myList = [];
// String id = '';
// List<dynamic> id = [];

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
    var responseData = json.decode(response.body.toString());
    var value = responseData['data'];

    myList = List.from(value);
    List<dynamic> myList1 = [];

    for (var i = 0; i < limit; i++) {
      String lead = myList[i]['documentNumber']['leadNumber'];

      myList1.add(lead);
    }

    String id = myList[limit - 1]['_id'];
    print(myList1);

    return [id, myList1];

    //return lead_id_number;
  } else {
    print('aaaaaaaaaaaaaaa');
  }
}
