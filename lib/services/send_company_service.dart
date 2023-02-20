import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future createAlbum(String companyId, String emailId, String password) async {
  final response = await http.post(
    Uri.parse('https://api.cargoez.dev/iamserver/api/v1/portal-login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'companyId': companyId,
      'emailId': emailId,
      'password': password
    }),
  );

  var sts = response.statusCode;
  if (sts == 200) {
    final responseData = json.decode(response.body);
    var value = responseData['data'];
    var refreshToken = value["refreshToken"];
    var contactId = value["contactId"];
    final growableList = <String>[refreshToken, contactId];

    return growableList;
  } else {
    //throw Exception('Failed to create album.');

    return null;
  }
}
