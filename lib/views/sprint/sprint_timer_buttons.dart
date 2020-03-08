import 'package:flutter/cupertino.dart';
import 'package:scatter/app_theme.dart';

class SprintTimerButtons extends StatelessWidget {
  final bool started;
  final AnimationController controller;
  final Function onCancelPressed;
  final Function onStartPressed;

  SprintTimerButtons({
    this.started,
    this.controller,
    this.onCancelPressed,
    this.onStartPressed
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: CupertinoButton(
            child: Text('Cancel'),
            color: AppTheme.accentColor,
            onPressed: started ? onCancelPressed : null
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
              onStartPressed : null
          )
        ),
      ]
    );
  }
}