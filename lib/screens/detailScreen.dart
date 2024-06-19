import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterelegantmedia/utils/next_Screen.dart';

import '../controller/apiCallController.dart';
import '../model/lisViewModel.dart';
import 'mapScreen.dart';

class DetailScreen extends StatelessWidget {
  final int? id;

  const DetailScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        actions: [
          IconButton(
            onPressed: () async {
              final post = await getOnePost(id!);
              nextScreen(
                  context,
                  MapScreen(
                      latitude: double.parse(post.latitude!),
                      longitude: double.parse(post.longitude!)));
            },
            icon: Icon(CupertinoIcons.location),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: getOnePost(id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final post = snapshot.data!;
              return viewOneDetails(post);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }

  Widget viewOneDetails(post) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(post.image?.large ?? '',
              errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/placeholder.png');
          }),
          const SizedBox(height: 10),
          Text(post.title ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
  }
}
