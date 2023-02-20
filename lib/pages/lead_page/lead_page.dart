import 'package:flutter/material.dart';
import 'package:login/services/provider.dart';
import 'package:provider/provider.dart';

class LeadPage extends StatefulWidget {
  const LeadPage({super.key, required this.contactId});
  final contactId;

  @override
  State<LeadPage> createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text(Provider.of<Id>(context).refreshToken),
          )
        ],
      ),
    ));
  }
}
