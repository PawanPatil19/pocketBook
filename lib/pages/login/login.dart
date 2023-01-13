import 'package:app_project/pages/login/loginBody.dart';
import 'package:flutter/material.dart';


// create a login page

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBody(),
    );
  }  
  
}
