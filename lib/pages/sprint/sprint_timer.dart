import 'package:flutter/cupertino.dart';
import 'dart:math';


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