import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NetworkImageWithProgress extends StatefulWidget {
  final String imageUrl;

  NetworkImageWithProgress({required this.imageUrl});

  @override
  _NetworkImageWithProgressState createState() =>
      _NetworkImageWithProgressState();
}

class _NetworkImageWithProgressState extends State<NetworkImageWithProgress> {
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

        //actual image
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
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.white,
                size: 30,
              ),
            );
          },
          errorBuilder: (
            BuildContext context,
            Object exception,
            StackTrace? stackTrace,
          ) {
            // Handle image loading errors
            return errorImagePlaceholder();
          },
        ), //),
      ],
    );
  }
}

Widget errorImagePlaceholder() {
  return Center(
    child: Text(
      'Oops. Failed to load image!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontFamily: "Montserrat",
      ),
    ),
  );
}
