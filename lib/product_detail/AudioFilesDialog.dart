import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/AppColors.dart';

class AudioFilesDialog extends StatefulWidget {
  final List<String> audioFiles;
  final List<String> audioTitles;

  const AudioFilesDialog({
    super.key,
    required this.audioFiles,
    required this.audioTitles,
  });

  @override
  State<AudioFilesDialog> createState() => _AudioFilesDialogState();
}

class _AudioFilesDialogState extends State<AudioFilesDialog> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _playingIndex;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
          if (state.processingState == ProcessingState.completed) {
            _position = Duration.zero;
            _isPlaying = false;
          }
        });
      }
    });

    // Listen to position changes
    _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null && mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> _playAudio(int index) async {
    // If we're already playing this track, toggle play/pause
    if (_playingIndex == index) {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } else {
      // Play a new track
      // Stop any current playback
      if (_playingIndex != null) {
        await _audioPlayer.stop();
      }

      setState(() {
        _playingIndex = index;
        _position = Duration.zero;
        _duration = Duration.zero; // Reset duration until new one is loaded
      });

      // Set the new source
      try {
        // Load the audio file and wait for it to be ready
        await _audioPlayer.setUrl(widget.audioFiles[index]);

        // Try to get the duration immediately after loading
        Duration? loadedDuration = await _audioPlayer.duration;
        if (loadedDuration != null && mounted) {
          setState(() {
            _duration = loadedDuration;
          });
        }

        // Play the new track
        await _audioPlayer.play();
      } catch (e) {
        debugPrint('Error playing audio: $e');
      }
    }
  }

  // Added helper method to show loading or actual duration
  String _getDurationText() {
    if (_duration == Duration.zero) {
      return "loading...";
    }
    return _formatDuration(_duration);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Audio Files",
        style: TextStyle(
          fontSize: 24,
          color: AppColors.background,
          fontWeight: FontWeight.w700,
          fontFamily: "Montserrat",
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.audioFiles.length,
          itemBuilder: (context, index) {
            final bool isCurrentlyPlaying =
                _playingIndex == index && _isPlaying;
            final bool isCurrentTrack = _playingIndex == index;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(
                  widget.audioTitles[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.background,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                ),
                subtitle:
                    isCurrentTrack
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LinearProgressIndicator(
                              backgroundColor: Color.fromARGB(
                                255,
                                179,
                                193,
                                222,
                              ),
                              color: AppColors.background,
                              value:
                                  _duration.inMilliseconds > 0
                                      ? _position.inMilliseconds /
                                          _duration.inMilliseconds
                                      : 0.0,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${_formatDuration(_position)} / ${_getDurationText()}",
                              style: const TextStyle(
                                color: AppColors.background,
                                fontFamily: "Montserrat",
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                        : null,
                trailing: IconButton(
                  icon: Icon(
                    isCurrentlyPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.background,
                  ),
                  onPressed: () => _playAudio(index),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _audioPlayer.stop();
            Navigator.of(context).pop();
          },
          child: const Text(
            "Close",
            style: TextStyle(
              color: AppColors.background,
              fontWeight: FontWeight.w600,
              fontFamily: "Montserrat",
            ),
          ),
        ),
      ],
    );
  }
}
