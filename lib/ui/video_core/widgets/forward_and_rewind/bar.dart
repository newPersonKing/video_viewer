import 'package:flutter/material.dart';
import 'package:video_viewer/data/repositories/video.dart';

class VideoCoreForwardAndRewindBar extends StatelessWidget {
  const VideoCoreForwardAndRewindBar({
    Key? key,
    required this.seconds,
    required this.position,
  }) : super(key: key);

  final int seconds;
  final Duration position;

  @override
  Widget build(BuildContext context) {
    final query = VideoQuery();
    final video = query.video(context).video!;
    final style = query.videoStyle(context);
    final forwardStyle = style.forwardAndRewindStyle;

    final duration = video.value.duration;
    final height = forwardStyle.bar.height;
    final width = forwardStyle.bar.width;

    return Center(
      child: Container(
        padding: forwardStyle.padding,
        decoration: BoxDecoration(
          color: forwardStyle.backgroundColor,
          borderRadius: forwardStyle.borderRadius,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            query.durationFormatter(Duration(seconds: seconds)),
            style: style.textStyle,
          ),
          SizedBox(height: forwardStyle.spaceBeetweenBarAndText),
          SizedBox(
            height: height,
            width: width,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: forwardStyle.bar.background,
                  borderRadius: forwardStyle.borderRadius,
                ),
              ),
              Container(
                height: height,
                width: ((position.inSeconds + seconds) / duration.inSeconds) *
                    width,
                decoration: BoxDecoration(
                  color: forwardStyle.bar.color,
                  borderRadius: forwardStyle.borderRadius,
                ),
              ),
              CustomPaint(
                painter: _InitialPositionIdentifierPainter(
                  color: forwardStyle.bar.identifier,
                  position: (position.inSeconds / duration.inSeconds) * width,
                  width: forwardStyle.bar.identifierWidth,
                ),
                size: Size.infinite,
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _InitialPositionIdentifierPainter extends CustomPainter {
  _InitialPositionIdentifierPainter({
    required this.color,
    required this.position,
    this.width = 2.0,
  });

  final Color color;
  final double position;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final RRect rect = RRect.fromRectAndRadius(
      Offset(position, -size.height / 2) & Size(width, size.height * 2),
      Radius.circular(width),
    );
    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(_InitialPositionIdentifierPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_InitialPositionIdentifierPainter oldDelegate) =>
      false;
}
