import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {

  final String videoUrl;

  VideoApp({required this.videoUrl});

  //const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.networkUrl(Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.videoUrl,
      ),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    //_controller.setLooping(true); // Optional: Loop the video
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: _initializeVideoPlayerFuture,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return Stack(
    //         alignment: Alignment.center,
    //         children: <Widget>[
    //           AspectRatio(
    //             aspectRatio: _controller.value.aspectRatio,
    //             child: VideoPlayer(_controller),
    //           ),
    //           IconButton(
    //             onPressed: () {
    //               setState(() {
    //                 if (_controller.value.isPlaying) {
    //                   _controller.pause();
    //                 } else {
    //                   _controller.play();
    //                 }
    //               });
    //             },
    //             icon: Icon(
    //               _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //               size: 60.0,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       );
    //     } else {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );


    return Scaffold(
      backgroundColor: Colors.black, // Black background
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    icon: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 60.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
