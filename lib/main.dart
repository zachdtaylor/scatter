import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scatter/check_platform.dart';
import 'package:scatter/home.dart';


void main() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  Widget home = Home();
  runApp(ScatterApp(home: home));
}

class ScatterApp extends StatelessWidget {
  final Widget home;
  final String title = 'Scatter';

  ScatterApp({Key key, @required this.home}): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if (isIos) {
      return CupertinoApp(
        title: title,
        home: home
      );
    } else {
      return MaterialApp(
        title: title,
        home: home
      );
    }
  }
}
