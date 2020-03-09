import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:scatter/app_theme.dart';


class SprintTimer extends AnimatedWidget {
  final AnimationController controller;

  SprintTimer({this.controller})
    : super(listenable: Tween<double>(begin:2*pi, end:0.0).animate(controller));

  String get timerString {
    Duration duration = controller.duration * 
      (1 - controller.value) + Duration(seconds:1);
    return duration.inHours.toString().padLeft(2, '0') + ':' +
    (duration.inMinutes % 60).toString().padLeft(2, '0') + ':' + 
    (duration.inSeconds % 60).toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: SprintTimerPainter(
              animation: listenable,
              color: AppTheme.primaryColor
            )
          )
        ),
        Align(
          alignment: FractionalOffset.center,
          child: Text(
            timerString,
            style: TextStyle(
              fontSize: 80.0,
              color: CupertinoColors.black
            )
          )
        )
      ],
    );
  }
}

class SprintTimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  SprintTimerPainter({
    this.animation,
    this.color
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Offset.zero & size, pi * 1.5, animation.value, false, paint);
  }
  @override
  bool shouldRepaint(SprintTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}