import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NetworkImageWithLoading extends StatefulWidget {
  final String imageUrl;

  NetworkImageWithLoading({required this.imageUrl});

  @override
  _NetworkImageWithLoadingState createState() =>
      _NetworkImageWithLoadingState();
}

class _NetworkImageWithLoadingState extends State<NetworkImageWithLoading> {
  double? _progress; // Nullable double to track progress

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Make the Stack fill the screen
      children: <Widget>[
        // Background Color using Container
        Container(
          color: Color.fromARGB(
            255,
            32,
            47,
            80,
          ), // Replace with your desired color
        ),

        Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
          // Cover the entire screen
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child; // Image is fully loaded
            }
            _progress =
                loadingProgress.cumulativeBytesLoaded /
                (loadingProgress.expectedTotalBytes ?? 1); // Calculate progress
            return Center(
              child:
              //CircularProgressIndicator(value: _progress)
              LoadingAnimationWidget.fourRotatingDots(
                color: Colors.white,
                size: 20,
              ),
            );
          },
          errorBuilder: (
            BuildContext context,
            Object exception,
            StackTrace? stackTrace,
          ) {
            // Handle image loading errors
            return Center(child: Text('Failed to load image'));
          },
        ), //),
      ],
    );
  }
}
