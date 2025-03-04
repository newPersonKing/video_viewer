import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_viewer/data/repositories/video.dart';

class VideoCorePlayer extends StatefulWidget {
  VideoCorePlayer({Key? key}) : super(key: key);

  @override
  _VideoCorePlayerState createState() => _VideoCorePlayerState();
}

class _VideoCorePlayerState extends State<VideoCorePlayer> {
  @override
  Widget build(BuildContext context) {
    final video = VideoQuery().video(context, listen: true).video;
    return Center(
      child: AspectRatio(
        aspectRatio: video!.value.aspectRatio,
        child: VideoPlayer(video),
      ),
    );
  }
}
