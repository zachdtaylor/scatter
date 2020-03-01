import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './sprint_timer.dart';


class SprintPage extends StatefulWidget {
  @override
  _SprintPageState createState() => _SprintPageState();
}

class _SprintPageState extends State<SprintPage> with TickerProviderStateMixin {
  AnimationController controller;
  Duration timerDuration = Duration.zero;
  bool started = false;
  bool paused = false;
  double value;

  _onTimerDurationChanged(Duration duration) {
    setState(() {
      timerDuration = duration;
      controller = AnimationController(
        vsync: this,
        duration: duration
      )..addListener(() {
        setState(() {
          value = controller.value;
        });
      });
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
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0)
    );
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

