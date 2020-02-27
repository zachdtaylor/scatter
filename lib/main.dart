import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:scatter/home.dart';


void main() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  Widget home = Home();
  runApp(ScatterApp(home));
}

class ScatterApp extends StatelessWidget {
  final Widget home;
  final String title = 'Scatter';

  ScatterApp(this.home);
  
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: title,
      home: home
    );
  }
}
