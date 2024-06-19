import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/lisViewModel.dart';

//all posts view api call
Future<List<Post>> getPosts() async {
  var url = Uri.parse(
      "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json");
  final response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (kDebugMode) {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  if (response.statusCode == 200) {
    //if response 200 pass data
    final Map<String, dynamic> body = json.decode(response.body);
    List<dynamic> postsJson = body['data'];

    return postsJson.map((e) => Post.fromJson(e)).toList();
  } else {
    //if error
    throw Exception('Failed to load posts');
  }
}

//view one posts api call
Future<Post> getOnePost(int id) async {
  var url = Uri.parse(
      "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json");
  final response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    //if response 200 pass data
    final Map<String, dynamic> body = json.decode(response.body);
    List<dynamic> postsJson = body['data'];
    final postJson = postsJson.firstWhere((element) => element['id'] == id,
        orElse: () => null);
    if (postJson != null) {
      return Post.fromJson(postJson);
    } else {
      throw Exception('Post not found');
    }
  } else {
    throw Exception('Failed to load post');
  }
}
