import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterelegantmedia/utils/config.dart';
import 'package:http/http.dart' as http;

import '../utils/next_Screen.dart';
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
          Center(
              child: FutureBuilder<List<Post>>(
            future: getPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final posts = snapshot.data!;
                return buildPosts(posts);
              } else {
                return const Text("No data available");
              }
            },
          ))
        ],
      ),
    );
  }

  static Future<List<Post>> getPosts() async {
    var url = Uri.parse(
        "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    print('response.body ${response.body}');
    return body.map((e) => Post.fromJson(e)).toList();
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

Widget buildPosts(List<Post> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      final post = posts[index];
      return Container(
        color: Colors.grey.shade300,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 100,
        width: double.maxFinite,
        child: Row(
          children: [
            Expanded(flex: 1, child: Image.network(post.image?.small ?? '')),
            SizedBox(width: 10),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.image?.medium ?? ''),
                    Text(post.title ?? ''),
                    Text(post.address ?? ''),
                  ],
                )),
          ],
        ),
      );
    },
  );
}

class Post {
  int? id;
  String? title;
  String? description;
  String? address;
  String? postcode;
  String? phoneNumber;
  String? latitude;
  String? longitude;
  PostImage? image;

  Post(
      {this.id,
      this.title,
      this.description,
      this.address,
      this.postcode,
      this.phoneNumber,
      this.latitude,
      this.longitude,
      this.image});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    address = json['address'];
    postcode = json['postcode'];
    phoneNumber = json['phoneNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'] != null ? PostImage.fromJson(json['image']) : null;
  }
}

class PostImage {
  String? small;
  String? medium;
  String? large;

  PostImage({this.small, this.medium, this.large});

  PostImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }
}
