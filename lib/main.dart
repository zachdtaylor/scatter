import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scatter/home.dart';
import 'package:scatter/app_theme.dart';


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
      home: home,
      theme: CupertinoThemeData(
        primaryColor: AppTheme.primaryColor
      )
    );
  }
}
