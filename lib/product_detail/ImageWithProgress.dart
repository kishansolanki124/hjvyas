import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageWithProgress extends StatefulWidget {
  final String imageURL;
  final BoxFit? boxFit;

  const ImageWithProgress({Key? key, required this.imageURL, this.boxFit})
    : super(key: key);

  @override
  _ImageWithProgressState createState() => _ImageWithProgressState();
}

class _ImageWithProgressState extends State<ImageWithProgress> {
  //double? _progress; // Nullable double to track progress

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Make the Stack fill the screen
      children: <Widget>[
        Image.network(
          widget.imageURL,
          fit: widget.boxFit ?? BoxFit.contain,
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
            return Center(
              child: Text(
                'Image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontFamily: "Montserrat",
                ),
              ),
            );
          },
        ), //),
      ],
    );
  }
}
