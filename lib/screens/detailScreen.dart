import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/lisViewModel.dart';

class DetailScreen extends StatelessWidget {
  final int? id;

  const DetailScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: FutureBuilder<Post>(
        future: getPostById(id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(post.image?.large ?? '',
                      errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/placeholder.png');
                  }),
                  const SizedBox(height: 10),
                  Text(post.title ?? '',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(post.description ?? ''),
                  const SizedBox(height: 10),
                  Text('Address: ${post.address ?? ''}'),
                  const SizedBox(height: 10),
                  Text('Postcode: ${post.postcode ?? ''}'),
                  const SizedBox(height: 10),
                  Text('Phone: ${post.phoneNumber ?? ''}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }

  static Future<Post> getPostById(int id) async {
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
}
