import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class IngredientsImageWithLoading extends StatefulWidget {
  final String imageUrl;

  IngredientsImageWithLoading({required this.imageUrl});

  @override
  _IngredientsImageWithLoadingState createState() =>
      _IngredientsImageWithLoadingState();
}

class _IngredientsImageWithLoadingState extends State<IngredientsImageWithLoading> {
  //double? _progress; // Nullable double to track progress

  @override
  Widget build(BuildContext context) {
        return Image.network(
          widget.imageUrl,
          fit: BoxFit.contain,
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
            //     (loadingProgress.expectedTotalBytes ?? 1); // Calculate progress
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
        );
  }
}
