import 'package:flutter/material.dart';
import 'package:flutterelegantmedia/utils/next_Screen.dart';

import '../model/lisViewModel.dart';
import '../screens/detailScreen.dart';
import '../utils/config.dart';

Widget buildPosts(List<Post> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      final post = posts[index];
      return GestureDetector(
        onTap: () {
          nextScreen(context, DetailScreen(id: post.id));
        },
        child: Container(
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(post.image?.large ?? '',
                    errorBuilder: (context, error, stackTrace) {
                  return Image.asset(Config.placeholder);
                }),
              ),
              SizedBox(width: 10),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title ?? ''),
                      Text(post.address ?? ''),
                    ],
                  )),
            ],
          ),
        ),
      );
    },
  );
}
