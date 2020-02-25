import 'package:flutter/cupertino.dart';

class SprintPage extends StatefulWidget {
  @override
  _SprintPageState createState() => _SprintPageState();
}

class _SprintPageState extends State<SprintPage> {
  _onTimerDurationChanged(Duration duration) {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoTimerPicker(
        onTimerDurationChanged: _onTimerDurationChanged,
      )
    );
  }
}
