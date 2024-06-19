import 'package:flutter/material.dart';

import '../utils/config.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String title;
  final String address;

  MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.address,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isInfoVisible = false;

  void _toggleInfoVisibility() {
    setState(() {
      _isInfoVisible = !_isInfoVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String staticMapUrl =
        _getStaticMapUrl(widget.latitude, widget.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text(Config.map),
      ),
      body: Stack(
        children: [
          // Placeholder for the marker
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleInfoVisibility,
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
          ),
          // Info box that appears on top of the marker when clicked
          if (_isInfoVisible)
            Positioned(
              bottom: MediaQuery.of(context).size.height / 2,
              left: MediaQuery.of(context).size.width / 2 - 150,
              child: Container(
                width: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.address),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getStaticMapUrl(double latitude, double longitude) {
    const apiKey =
        'AIzaSyCSvnqHhGHM0-cGgRetzbw5rzS1G_G9zEo'; // Replace with your Google Static Maps API key
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=14&size=600x300&maptype=roadmap'
        '&markers=color:red%7Clabel:%7C$latitude,$longitude&key=$apiKey';
  }
}
