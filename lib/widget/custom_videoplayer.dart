import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String selectedUrl;
  final PreferredSizeWidget appBar;
  final Function callBackVideoFinished;
  final bool autoPlay;
  final bool looping;

  CustomVideoPlayer({
    Key key,
    @required this.selectedUrl,
    this.appBar,
    this.callBackVideoFinished,
    this.autoPlay = false,
    this.looping = false,
  })  : assert(selectedUrl != null && autoPlay != null && looping != null),
        assert(selectedUrl.length != 0),
        super(key: key);

  @override
  CustomVideoPlayerState createState() => CustomVideoPlayerState();
}

class CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController _controller;
  VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _createListener();
    _createVideo();
  }

  void _createListener() {
    _listener = () {
      if (!mounted) return;
      setState(() {});
      if (_controller != null) {
        if (isEndedVideo() && widget.callBackVideoFinished != null) {
          widget.callBackVideoFinished();
        }
      }
    };
  }

  void _createVideo() {
    if (_controller != null) return;

    _controller = VideoPlayerController.network(widget.selectedUrl)
      ..addListener(_listener)
      ..setVolume(1.0)
      ..setLooping(widget.looping)
      ..initialize();

    if (widget.autoPlay) {
      _controller.play();
    }
  }

  void playPauseVideo() {
    if (!mounted) return;
    if (isEndedVideo()) return;
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  bool isEndedVideo() {
    if (_controller.value.position == _controller.value.duration) return true;
    return false;
  }

  Duration getVideoDuration() {
    return _controller.value.position;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: (_controller != null
          ? GestureDetector(
              onTap: () => playPauseVideo(),
              child: VideoPlayer(_controller),
            )
          : Container()),
    );
  }
}
