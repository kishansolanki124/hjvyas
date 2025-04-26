import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FloatingImageViewer extends StatelessWidget {
  final String imageUrl;
  final Function() onClose;

  const FloatingImageViewer({
    super.key,
    required this.imageUrl,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Color.fromARGB(175, 31, 47, 80),
        child: Stack(
          children: [
            // Center image with zoom functionality
            Center(
              child: Hero(
                tag: imageUrl,
                child: PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2.5,
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  loadingBuilder:
                      (context, event) => Center(
                        child: CircularProgressIndicator(
                          value:
                              event == null
                                  ? 0
                                  : event.cumulativeBytesLoaded /
                                      (event.expectedTotalBytes ?? 1),
                          color: Colors.white,
                        ),
                      ),
                  errorBuilder:
                      (context, error, stackTrace) => Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.broken_image,
                              color: Colors.white,
                              size: 48,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Image failed to load",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                ),
              ),
            ),

            // Close button
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(175, 31, 47, 80),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    onClose;
                  },
                ),
              ),
            ),

            // // Instructions text
            // Positioned(
            //   bottom: 30,
            //   left: 0,
            //   right: 0,
            //   child: Center(
            //     child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //       decoration: BoxDecoration(
            //         color: Colors.black.withOpacity(0.5),
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: Text(
            //         "Pinch to zoom • Double tap to reset",
            //         style: TextStyle(color: Colors.white70),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
