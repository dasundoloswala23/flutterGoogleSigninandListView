import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/config.dart';
import '../utils/next_Screen.dart';
import 'homscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Config.login_title)),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 100,
                width: 100,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    iconSize: 20,
                    icon: Image.asset(
                      'assets/google_icon.png',
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      User? user = await signInWithGoogle();
                      setState(() {
                        isLoading = false;
                      });
                      if (user != null) {
                        nextScreen(context, HomeScreen(user: user));
                      }
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } on Exception catch (e) {
      // Handle the error
      if (kDebugMode) {
        print('exception->$e');
      }
      return null;
    }
  }
}
