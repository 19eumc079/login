import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/inquiries_models/inquiries_models.dart';

import 'package:login/services/provider.dart';
import 'package:provider/provider.dart';

class LeadPage extends StatefulWidget {
  const LeadPage({super.key});

  @override
  State<LeadPage> createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;

  List<Lead> leads = [];
  String lastId = "null";
  String lastId1 = '';
  bool hasMore = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    getData(lastId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: scrollController,
        itemExtent: 80,
        itemBuilder: (BuildContext context, int index) {
          if (index == leads.length) {
            if (!hasMore) {
              return Center(
                child: Text('No more data'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return Card(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(leads[index].leadNumber),
                ),
                trailing: Text(leads[index].name),
              ),
            );
          }
        },
        itemCount: leads.length + 1,
      ),
    );
  }

  Future getData(String lastId) async {
    String refreshToken = Provider.of<Id>(context, listen: false).refreshToken;
    String contactId = Provider.of<Id>(context, listen: false).contactId;
    int limit = 10;
    final response = await http.get(
      Uri.parse(
          'https://api.cargoez.dev/leadserver/api/v1/portal/leads/paginate/$contactId/$limit/$lastId?form={}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': refreshToken,
      },
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body.toString());
      var value = responseData['data'];
      print('----------------------------------------------------------');

      for (int i = 0; i < limit; i++) {
        if (i < value.length) {
          print(i);
          print(value.length);
          // String leadNumber = (value[i]['documentNumber']['leadNumber']);
          // String name = (value[i]['currentStage']['name']);
          var lead = Lead.fromJson(value[i]);

          leads.add(lead);
        } else {
          hasMore = false;
          break;
        }
      }

      if (value.length == limit) {
        setState(() {
          lastId1 = value[limit - 1]['_id'];
        });
      }
    } else {
      print('Something Wrong');
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        hasMore) {
      setState(() {
        isLoadingMore = true;
      });

      await getData(lastId1);

      setState(() {
        isLoadingMore = false;
      });
    }
  }
}
