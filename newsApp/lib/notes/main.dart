/*
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../auth_/login_info.dart';
import 'pages/home_note.dart';
import 'pages/login.dart';

Future<void> main() async {
// Initialized FireBase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogIn = false;
*/
/**//*

// Checks if user is logged or not
  getLoggedInState() async {
    await LocalDataSaver.getLogData().then((value) {
      setState(() {
        isLogIn = value.toString() == "null";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getLoggedInState();
  }

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'KeepNote',
        home: AnimatedSplashScreen(
          splashIconSize: 140,
          splash: Image.asset(
            'assets/images/men_pen_logo-removebg-preview.png',
          ),
          nextScreen: isLogIn ? const Login() : const Home(),
          splashTransition: SplashTransition.rotationTransition,
        ));
  }
}
*/
