import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
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
    )
    ..addStatusListener((status)  {
      if (status == AnimationStatus.completed) {
        FlutterRingtonePlayer.play(
          android: AndroidSounds.alarm,
          ios: IosSounds.alarm,
          asAlarm: true
        );
        // May need to wrap this in Future.delayed(Duration.zero, ...)
        // if something goes wrong later...
        _createDialog(context);
        _resetTimer();
      }
    });
  }

  _resetTimer() {
    setState(() {
      controller.reset();
      started = false;
    });
  }

  _onTimerDurationChanged(Duration duration) {
    setState(() {
      controller.duration = duration;
    });
  }

  _onCancelPressed() {
    _resetTimer();
  }

  _onStartPressed() {
    if (!started) {
      setState(() {
        started = true;
        animation = Tween<double>(begin:2*pi, end:0.0).animate(controller);
      });
    } 
    if (controller.isAnimating) {
      controller.stop();
    } else {
      controller.forward();
    }
  }

  _createDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Sprint Finished!"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Discard"),
              onPressed: () => Navigator.pop(context),
              isDestructiveAction: true,
            )
          ],
        );
      }
    );
  }

  String get timerString {
    Duration duration = controller.duration * (1 - controller.value) + Duration(seconds:1);
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
                        onPressed: controller.duration != Duration() ?
                          _onStartPressed : null
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

