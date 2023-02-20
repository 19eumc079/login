import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login/pages/pages.dart';
import 'package:http/http.dart' as http;

Future fetchAlbum(String company) async {
  final response = await http.get(
      Uri.parse('https://api.cargoez.dev/iamserver/api/v1/companies/jio/url'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseData = json.decode(response.body);

    var value = responseData['data']['company'];

    // Use the value in your app

    var data = value.firstWhere((e) => e["portal_url_id"] == company,
        orElse: () => null);

    if (data != null) {
      var data3 = data['id'];
      return data3;
    } else
      return null;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ');
  }
}
