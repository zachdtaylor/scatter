import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class SprintTimer extends StatefulWidget {
  @override
  _SprintTimerState createState() => _SprintTimerState();
}

class _SprintTimerState extends State<SprintTimer> with TickerProviderStateMixin {
  AnimationController controller;
  Duration timerDuration = Duration.zero;
  bool started = false;
  bool paused = false;

  _onTimerDurationChanged(Duration duration) {
    setState(() {
      timerDuration = duration;
      controller = AnimationController(
        vsync: this,
        duration: duration
      );
    });
  }

  _onCancelPressed() {
    setState(() {
      controller.reset();
      started = false;
    });
  }

  _onStartPressed() {
    setState(() {
      started = true;
    });
    if (controller.isAnimating)
      controller.stop();
    else {
      controller.reverse(
        from: controller.value == 0.0
          ? 1.0
          : controller.value
      );
    }
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return duration.inHours.toString().padLeft(2, '0') + ':' +
    (duration.inMinutes % 60).toString().padLeft(2, '0') + ':' + 
    (duration.inSeconds % 60).toString().padLeft(2, '0');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: started ? Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: SprintTimerPainter(
                                  animation: controller,
                                  backgroundColor: CupertinoColors.activeGreen,
                                  color: CupertinoColors.black
                                )
                              );
                            }
                          )
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return Text(
                                timerString,
                                style: TextStyle(
                                  fontSize: 80.0,
                                  color: CupertinoColors.black
                                )
                              );
                            }
                          )
                        )
                      ],
                    ) : CupertinoTimerPicker(
                      initialTimerDuration: timerDuration,
                      onTimerDurationChanged: _onTimerDurationChanged,
                    )
                  )
                )
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Row(
                      children: <Widget>[
                        CupertinoButton(
                          child: Text('Cancel'),
                          onPressed: _onCancelPressed
                        ),
                        CupertinoButton(
                          child: Text(
                            controller.isAnimating ? 'Pause' : 'Start'
                          ),
                          onPressed: _onStartPressed
                        ),
                      ]
                     )
                  );
                }
              )
            ],
          )
        );
      }
    );
  }
}

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
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
  }
  @override
  bool shouldRepaint(SprintTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}