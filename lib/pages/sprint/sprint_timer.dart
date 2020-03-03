import 'package:flutter/cupertino.dart';
import 'dart:math';


class SprintTimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor, color;

  SprintTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    paint.color = color;
    canvas.drawArc(Offset.zero & size, pi * 1.5, animation.value, false, paint);
  }
  @override
  bool shouldRepaint(SprintTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}