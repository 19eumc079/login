import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login/pages/firstpage/firstpage.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/Portal.gif',
          fit: BoxFit.fitHeight,
        ));
  }
}
