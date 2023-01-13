import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

final _auth = FirebaseAuth.instance;

class _RegisterBodyState extends State<RegisterBody> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          
          Stack(
            children: [
              Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/loginPage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          

          Container(
            height: size.height * 0.7,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(119, 204, 204, 204),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // add a text
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      firstName = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "First Name",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide( 
                          width: 2,
                          color: kSecondaryColor
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
    
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:TextField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      lastName = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "Last Name",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide( 
                          width: 2,
                          color: kSecondaryColor
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
    
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "Email",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide( 
                          width: 2,
                          color: kSecondaryColor
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
    
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "Password",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide( 
                          width: 2,
                          color: kSecondaryColor
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
    
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                  
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2, 
                          color: kSecondaryColor
                        )
                      ),
                    ),
                  ),
                ),              
                const SizedBox(
                  height: 40,
                ),
    
                
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (password == confirmPassword) {
                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          
                          if (newUser != null) {
                            await FirebaseFirestore.instance.collection('users').
                            add({
                              'firstName': firstName,
                              'lastName': lastName,
                              'email': email,
                            });
                            Navigator.pushNamed(context, 'signin_screen');
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ]
            ),
          )
    
        ]
      ),
    );
  }
}