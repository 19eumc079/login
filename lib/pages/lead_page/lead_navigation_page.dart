import 'package:flutter/material.dart';

import 'lead_page.dart';

class LeadNavigationPage extends StatelessWidget {
  const LeadNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LeadPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text('LEAD'),
            )),
      ),
    );
  }
}
