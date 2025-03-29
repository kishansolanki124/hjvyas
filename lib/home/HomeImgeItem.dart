import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';

class NetworkImageWithProgress extends StatefulWidget {
  final String imageUrl;

  NetworkImageWithProgress({required this.imageUrl});

  @override
  _NetworkImageWithProgressState createState() =>
      _NetworkImageWithProgressState();
}

class _NetworkImageWithProgressState extends State<NetworkImageWithProgress> {
  double? _progress; // Nullable double to track progress

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Make the Stack fill the screen
      children: <Widget>[
        // Background Color using Container
        Container(
          color: Color.fromARGB(255, 32, 47, 80), // Replace with your desired color
        ),
        // Background Image
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
            return Center(child:
            //CircularProgressIndicator(value: _progress)
            LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white,
              size: 20,
            )
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
        ),

        // Text at Center Bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color.fromARGB(31, 0, 0, 0), Colors.transparent],
              ),
            ),
            child: Text(
              "Standard\nKachori",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
    // return Image.network(
    //   url,
    //   fit: BoxFit.cover,
    //   height: double.infinity,
    //   width: double.infinity,
    //   alignment: Alignment.center,
    // );
  }
}