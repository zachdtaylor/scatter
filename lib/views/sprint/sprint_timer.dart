import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:scatter/app_theme.dart';


class SprintTimer extends StatelessWidget {
  final Animation<double> animation;
  final String timerString;

  SprintTimer({this.animation, this.timerString});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                painter: SprintTimerPainter(
                  animation: animation,
                  color: AppTheme.primaryColor
                )
              );
            }
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