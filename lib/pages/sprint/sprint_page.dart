import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scatter/app_theme.dart';
import './sprint_timer.dart';


class SprintPage extends StatefulWidget {
  @override
  _SprintPageState createState() => _SprintPageState();
}

class _SprintPageState extends State<SprintPage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool started = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0)
    );
  }

  _onTimerDurationChanged(Duration duration) {
    controller.duration = duration;
  }

  _onCancelPressed() {
    setState(() {
      controller.reset();
      started = false;
    });
  }

  _onStartPressed() {
    if (!started) {
      setState(() {
        started = true;
        animation = Tween<double>(begin:2*pi, end:0.0).animate(controller);
      });
    } 
    if (controller.isAnimating) {
      setState(() {
        controller.stop();
      });
    } else {
      controller.forward();
    }
  }

  String get timerString {
    Duration duration = controller.duration * (1 - controller.value);
    return duration.inHours.toString().padLeft(2, '0') + ':' +
    (duration.inMinutes % 60).toString().padLeft(2, '0') + ':' + 
    (duration.inSeconds % 60).toString().padLeft(2, '0');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                    child: started ? SprintTimer(
                      animation: animation,
                      timerString: timerString,
                    ) : CupertinoTimerPicker(
                      initialTimerDuration: controller.duration,
                      onTimerDurationChanged: _onTimerDurationChanged,
                    )
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 30,
                      child: CupertinoButton(
                        child: Text('Cancel'),
                        color: AppTheme.accentColor,
                        onPressed: started ? _onCancelPressed : null
                      ),
                    ),
                    Spacer(flex: 1),
                    Expanded(
                      flex: 30,
                      child: CupertinoButton(
                        child: Text(
                          controller.isAnimating ? 'Pause' : 'Start'
                        ),
                        color: AppTheme.primaryColor,
                        onPressed: _onStartPressed
                      )
                    ),
                  ]
                )
              ),
            ],
          )
        );
      }
    );
  }
}

