import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterelegantmedia/utils/config.dart';

import '../controller/apiCallController.dart';
import '../controller/signOutFromGoogle.dart';
import '../model/lisViewModel.dart';
import '../utils/colors.dart';
import '../utils/next_Screen.dart';
import '../view/listView.dart';
import 'loginScreen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Config.app_title),
        centerTitle: true,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Column(
            children: [
              const SizedBox(height: 30),
              Text(user.displayName ?? Config.noNameAvailable),
              const SizedBox(height: 5),
              Text(user.email ?? Config.noEmailAvailable),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () async {
                  bool result = await signOutFromGoogle();
                  if (result) {
                    nextScreen(context, LoginScreen());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor, // Button color
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: 10), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded edges
                  ),
                ),
                child: Text(
                  Config.logout,
                  style:
                      TextStyle(fontSize: 18, color: Colors.white // Text size
                          ),
                ),
              )
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
