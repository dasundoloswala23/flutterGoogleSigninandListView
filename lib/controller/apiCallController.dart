import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/lisViewModel.dart';

Future<List<Post>> getPosts() async {
  var url = Uri.parse(
      "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json");
  final response =
      await http.get(url, headers: {"Content-Type": "application/json"});

// Log the response status and body
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> body = json.decode(response.body);
    List<dynamic> postsJson =
        body['data']; // Adjust to match the actual JSON structure
    return postsJson.map((e) => Post.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<Post> getOnePost(int id) async {
  var url = Uri.parse(
      "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json");
  final response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
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
