import 'package:flutter/cupertino.dart';

class SprintPage extends StatefulWidget {
  @override
  _SprintPageState createState() => _SprintPageState();
}

class _SprintPageState extends State<SprintPage> {
  _onTimerDurationChanged(Duration duration) {

  }

  _onCancelPressed() {

  }

  _onStartPressed() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CupertinoTimerPicker(
            onTimerDurationChanged: _onTimerDurationChanged,
          ),
          Row(
            children: <Widget>[
              CupertinoButton(
                child: Text('Cancel'),
                onPressed: _onCancelPressed
              ),
              CupertinoButton(
                child: Text('Start'),
                onPressed: _onStartPressed
              ),
            ]
          ),
        ]
      )
    );
  }
}
