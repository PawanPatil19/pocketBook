import 'dart:async';

import 'package:app_project/pages/home/homepage.dart';
import 'package:app_project/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }
  
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  } route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
      )
    ); 
  }
  
  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[            
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "pocketBook",
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                fontFamily: 'Poppins'
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            SpinKitFoldingCube(
              color: Colors.white,
              size: 50.0,
            )
         ],
       ),
      ),
    );
  }
}