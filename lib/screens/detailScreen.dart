import 'package:flutter/material.dart';
import 'package:flutterelegantmedia/utils/next_Screen.dart';

import '../controller/apiCallController.dart';
import '../model/lisViewModel.dart';
import '../utils/colors.dart';
import '../utils/config.dart';
import '../view/viewOneDetails.dart';
import 'mapScreen.dart';

class DetailScreen extends StatelessWidget {
  final int? id;

  const DetailScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Config.details),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: appColor,
        actions: [
          IconButton(
            onPressed: () async {
              final post = await getOnePost(id!);
              nextScreen(
                  context,
                  MapScreen(
                    latitude: double.parse(post.latitude!),
                    longitude: double.parse(post.longitude!),
                    title: post.title!,
                    address: post.address!,
                  ));
            },
            icon: Image.asset(Config.locationMark),
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
}
