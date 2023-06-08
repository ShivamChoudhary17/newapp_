import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../../auth_/auth.dart';
import '../../auth_/login_info.dart';
import '../services/firestore_db.dart';
import 'home_note.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // using firebase for login in app
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Image in login page
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: SizedBox(
                  height: 400,
                  child: Image.asset("assets/images/note_login.png"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // Text
              FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  child: Text(
                    "Create Better Together",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900),
                  )),
              const SizedBox(
                height: 10,
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  child: Text(
                    "Join Our Community",
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  )),
              const SizedBox(
                height: 15,
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  delay: const Duration(milliseconds: 200),
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              const SizedBox(
                height: 20,
              ),
              /*GOOGLE SIGN_IN BUTTON*/
              FadeInUp(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SignInButton(Buttons.Google, onPressed: () async {
                        await signInWithGoogle(); // function helps to signIn
                        final User? currentUser = _auth.currentUser;
                        LocalDataSaver.saveLoginData(true);
                        LocalDataSaver.saveImg(currentUser!.photoURL.toString());
                        LocalDataSaver.saveMail(currentUser.email.toString());
                        LocalDataSaver.saveSyncSet(false);
                        LocalDataSaver.saveName(currentUser.displayName.toString());
                        await FireDB().getAllStoredNotes();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const HomeNote()));
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
