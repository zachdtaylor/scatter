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
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (animation.value - 1.0) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, progress, false, paint);
  }
  @override
  bool shouldRepaint(SprintTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}