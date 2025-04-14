import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadImageWithProgress(String imageUrl) {
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

      //Background Image
      ColorFiltered(
        colorFilter: ColorFilter.mode(
          Color.fromARGB(150, 0, 0, 0),
          BlendMode.darken,
        ),
        child: Image.network(
          imageUrl,
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
            // _progress =
            //     loadingProgress.cumulativeBytesLoaded /
            //         (loadingProgress.expectedTotalBytes ?? 1); // Calculate progress
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(50),
                child:
                //CircularProgressIndicator(value: _progress)
                LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 20,
                ),
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
      ), //),
    ],
  );
}
