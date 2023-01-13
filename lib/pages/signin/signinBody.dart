import 'package:app_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../home/homepage.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

final _auth = FirebaseAuth.instance;

class _SignInBodyState extends State<SignInBody> {
  String email = '';
  String password = '';
  
  @override
  
  Widget build(BuildContext context) {
    // add background color
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        // add a back button 
        Stack(
          children: [
            Container(
              height: size.height * 0.4,
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
                  Navigator.pushNamed(context, 'welcome_screen');
                },
              ),
            ),
          ],
        ),
          
              
  

        Container(
          height: size.height * 0.6,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(119, 204, 204, 204),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              // add an image
              const Image(
                image: AssetImage("assets/images/user_login.png"),
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 30,
              ),
                              
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  cursorColor: Colors.grey,
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
                    ),
                  ),
                ),
              ),
              
              const SizedBox(
                height: 30,
              ),
              // add a login button
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () async{
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(email: email),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              
              // TextButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, 'signup');
              //   },
              //   child: Text("Forgot Password?",
              //   style: TextStyle(
              //     color: kTextColor,
              //     fontSize: 12,
              //     fontFamily: 'Poppins',
              //   ),
              // ),
              // ),
            ],
          ),
        ),

        
      ],
    );
  }
}