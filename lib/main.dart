import 'package:app_project/constants.dart';
import 'package:app_project/pages/home/homepage.dart';
import 'package:app_project/pages/login/login.dart';
import 'package:app_project/pages/register_user/register.dart';
import 'package:app_project/pages/signin/signin.dart';
import 'package:app_project/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('Firebase initialized');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Firebase not initialized');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallet App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: ColorScheme.light().copyWith(primary: kPrimaryColor),        
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const LoginPage(),
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen' : (context) => SplashScreen(),
        'welcome_screen': (context) => LoginPage(),
        'register_screen': (context) => RegisterBody(),
        'signin_screen': (context) => SignInPage(),
      },
      
    );
  }
}



