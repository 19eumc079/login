import 'package:flutter/material.dart';
import 'package:login/pages/lead_page/lead_page.dart';
import 'package:login/services/lead_service.dart';
import 'package:provider/provider.dart';

import '../../services/provider.dart';

class LeadButton extends StatefulWidget {
  const LeadButton({super.key});

  @override
  State<LeadButton> createState() => _LeadButtonState();
}

class _LeadButtonState extends State<LeadButton> {
  void _submit() async {
    print("-----------------------------------------------------------------");
    String refreshToken = Provider.of<Id>(context, listen: false).refreshToken;
    String contactId = Provider.of<Id>(context, listen: false).contactId;
    int limit = 10;
    String lastId = "null";

    var result = getData(contactId, limit, lastId, refreshToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: _submit, child: Text("Lead")),
      ),
    );
  }
}
