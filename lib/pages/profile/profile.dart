import 'package:app_project/pages/profile/profileBody.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ProfilePage extends StatefulWidget {
  
  final String email;
  const ProfilePage({Key? key, required this.email}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState(email);
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  _ProfilePageState(this.email);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ProfileBody(email: email),
    );
  }

  AppBar buildAppBar() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMMM yyyy, EEEEE');
    final String formatted = formatter.format(now);
    return AppBar(
      elevation: 0,
      // add text
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: kTextColor, size: 25,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      //add padding to the right of the appbar
        
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout_outlined, color: kTextColor, size: 25,),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  content: const Text('Logout?', style: TextStyle(fontFamily: 'Poppins', fontSize: 20),),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, 'signin_screen');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                        child: const Text("Ok", style: TextStyle(color: Colors.white) ,),
                      ),
                    )
                  ],
                )
            );

          },
        ),
        const Padding(padding: EdgeInsets.only(right: kDefaultPadding)),
      ],
    );
  }
}