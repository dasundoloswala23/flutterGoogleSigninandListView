import 'package:flutter/cupertino.dart';

import '../utils/config.dart';

//view one data code
Widget viewOneDetails(post) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(post.image?.large ?? '',
            errorBuilder: (context, error, stackTrace) {
          return Image.asset(Config.placeholder);
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
