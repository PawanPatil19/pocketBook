import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../profile/profile.dart';
import 'components/body.dart';

class HomePage extends StatefulWidget {
  
  final String email;
  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(this.email);
}

class _HomePageState extends State<HomePage> {
  String email = '';
  _HomePageState(this.email);

  Future<bool> _onWillPop() async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(

          title: const Text('Logout?', style: TextStyle(fontFamily: 'Poppins', fontSize: 20,),),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
              child: const Text('No', style: TextStyle(fontFamily: 'Poppins', color: kTextColor),),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
              child: const Text('Yes', style: TextStyle(fontFamily: 'Poppins', color: kTextColor)),
            ),
          ],
        ),
      )) ??
      false;
}

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: buildAppBar(email: email),
        body: Body(email: email),
      ),
    );
  }

  AppBar buildAppBar({required String email}) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMMM yyyy, EEEEE');
    final String formatted = formatter.format(now);
    return AppBar(
      elevation: 0,
      // add text
      title: Text(formatted, style: const TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'Poppins',)),
      leadingWidth: 0,
      //add padding to the right of the appbar
        
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.person_outline_rounded, color: kTextColor, size: 25,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(email: email),
              ),
            );
          },
        ),
        const Padding(padding: EdgeInsets.only(right: kDefaultPadding)),
      ],
    );
  }
}

