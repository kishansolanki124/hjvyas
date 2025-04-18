import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

class VideoViewForHome extends StatefulWidget {
  final String videoUrl;

  const VideoViewForHome({required this.videoUrl});

  @override
  _VideoViewForHomeState createState() => _VideoViewForHomeState();
}

class _VideoViewForHomeState extends State<VideoViewForHome> {
  bool _videoEnded = false;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.addListener(_videoListener);
    });
    //_controller.setLooping(true); // Optional: Loop the video
  }

  void _videoListener() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        _videoEnded = true;
      });
    } else {
      setState(() {
        _videoEnded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 47, 80), // Black background
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
                  if (_videoEnded) // Show play button when video ends
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _videoEnded = false;
                        });
                        _controller.seekTo(Duration.zero);
                        _controller.play();
                      },
                      icon: Icon(
                        Icons.play_arrow, // Change to replay icon if you want
                        size: 60.0,
                        color: Colors.white,
                      ),
                    )
                  else
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
                        _controller.value.isPlaying ? null : Icons.play_arrow,
                        size: 60.0,
                        color: Colors.white,
                      ),
                    ),
                ],
              );
            } else {
              //loading (buffering) of video
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 30,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }
}
