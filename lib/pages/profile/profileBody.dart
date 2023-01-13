import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ProfileBody extends StatefulWidget {
  
  final String email;
  const ProfileBody({Key? key, required this.email}) : super(key: key);


  @override
  State<ProfileBody> createState() => _ProfileBodyState(email);
}

class _ProfileBodyState extends State<ProfileBody> {
  String email = '';
  _ProfileBodyState(this.email);

  void initState() {
    super.initState();
    getUserInfo();
  }


  String firstName = '';
  String lastName = '';
  String email_user ='';


  Future getUserInfo() async {

    var query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();

    setState(() {
      firstName = query.docs[0].get('firstName');
      lastName = query.docs[0].get('lastName');
      email_user = query.docs[0].get('email');
    });

  }


  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kDefaultPadding * 2),

 
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: const Text(
            'My Profile',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: kTextColor,
            ),
          ),
        ),
      

        const SizedBox(
          height: 20,
        ),

        Image.asset(
          'assets/images/user_login.png',
          width: 100,
          height: 100,
        ),

        const SizedBox(
          height: 20,
        ),

        Container(
          margin: const EdgeInsets.all(kDefaultPadding),
          width: double.infinity,
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('First Name', style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                color: Colors.grey,
                ),
              ),
              Text(firstName, style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                color: kTextColor,
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: const EdgeInsets.all(kDefaultPadding),
          width: double.infinity,
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Last Name', style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                color: Colors.grey,
                ),
              ),
              Text(lastName, style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                color: kTextColor,
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: const EdgeInsets.all(kDefaultPadding),
          width: double.infinity,
          padding: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email', style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                color: Colors.grey,
                ),
              ),
              Text(email_user, style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                color: kTextColor,
                ),
              ),
            ],
          ),
        ),


        SizedBox(
          height: 10,
        ),

        //add a logout button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [              
              TextButton(
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
                child: const Text('Logout', style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),



      ],
        
    );
  }

}