import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterelegantmedia/utils/config.dart';

import '../controller/apiCallController.dart';
import '../controller/signOutFromGoogle.dart';
import '../model/lisViewModel.dart';
import '../utils/next_Screen.dart';
import '../view/listView.dart';
import 'loginScreen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Config.app_title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Column(
            children: [
              Text(user.displayName ?? Config.noNameAvailable),
              const SizedBox(height: 10),
              Text(user.email ?? Config.noEmailAvailable),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  bool result = await signOutFromGoogle();
                  if (result) {
                    nextScreen(context, LoginScreen());
                  }
                },
                child: const Text(Config.logout),
              ),
            ],
          )),
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: getPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final posts = snapshot.data!;
                  return buildPosts(posts);
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return const Text("No data available");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
