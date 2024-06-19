import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  MapScreen({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final String staticMapUrl = _getStaticMapUrl(latitude, longitude);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              staticMapUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text('Failed to load map'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getStaticMapUrl(double latitude, double longitude) {
    const apiKey =
        'AIzaSyBVoFRhTt2BqLsgnHfzNLlVxPPEblyCYdk'; // Replace with your Google Static Maps API key
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=14&size=600x300&maptype=roadmap'
        '&markers=color:red%7Clabel:L%7C$latitude,$longitude&key=$apiKey';
  }
}
