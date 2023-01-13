import 'package:app_project/constants.dart';

import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // add color to the background
      children: [
        
        // return a container with box with image
        Container(
          margin: const EdgeInsets.all(10),       
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/login_pic.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //add a text container
        Container(
          margin: const EdgeInsets.only(top: 40),
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              'pocketBook',
              style: TextStyle(
                color: kTextColor,
                fontSize: 50,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // add a container for text
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 40),
          child: const Center(
            child: Text(
              'Easiest way to manage your money',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),

        
        Expanded(
          
          child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          
          children: [
            // add a button for login
            Container(
              margin: const EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color.fromARGB(255, 218, 216, 216),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, 'signin_screen');
                  },
                  child: const Text('Login',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                  ),
                ),
              ),
            ),

            // add a button for register
            Container(
              margin: const EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(                
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color.fromARGB(255, 218, 216, 216),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, 'register_screen');
                  },
                  child: const Text('Register',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ),
                ),
              ),
            ),
          ],
        ),
        ),
        
      ]
    );
  }
}