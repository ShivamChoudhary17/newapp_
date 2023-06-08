import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/theme/theme.dart';
import 'package:provider/provider.dart';
import 'auth_/login.dart';
import 'auth_/login_info.dart';
import 'bottomNavBar/bottomnavigationbar.dart';

/*void main() {
  runApp(const MyApp());
}*/
Future<void> main() async {
// Initialized FireBase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);*/

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogIn = false;


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
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'QuickNEWS',
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home:  AnimatedSplashScreen(
            splashIconSize: 230,
            splash: Image.asset(
              'images/news.png',
            ),
            nextScreen: isLogIn ? const Login() : const BottomNavBar(),
            splashTransition: SplashTransition.rotationTransition,
          ),
        );
      });
}
