import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginScreen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.black54)),
              child: Image.network(user.photoURL ?? ''),
            ),
            const SizedBox(height: 20),
            Text(user.displayName ?? 'No name available'),
            const SizedBox(height: 20),
            Text(user.email ?? 'No email available'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                bool result = await signOutFromGoogle();
                if (result) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
