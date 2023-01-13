
import 'package:app_project/pages/signin/signinBody.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SignInBody(),
    );
  }  
  
}
