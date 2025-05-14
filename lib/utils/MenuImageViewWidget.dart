import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MenuImageViewWidget extends StatefulWidget {
  final String imageUrl;

  MenuImageViewWidget({required this.imageUrl});

  @override
  _MenuImageViewWidgetState createState() => _MenuImageViewWidgetState();
}

class _MenuImageViewWidgetState extends State<MenuImageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Make the Stack fill the screen
      children: <Widget>[
        // Background Color using Container
        Container(
          color: Colors.black, // Replace with your desired color
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
            return Padding(
              padding: EdgeInsets.only(top: 150),
              child: Align(
                alignment: Alignment.topCenter,
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 30,
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
