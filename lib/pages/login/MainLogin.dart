import 'package:flutter/material.dart';
import 'package:revire/main.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/constants/GlobalState.dart';
import 'dart:developer' as developer;

class MainLogin extends StatefulWidget {
  MainLogin({Key key}) : super(key: key);

  @override
  MainLoginState createState() => new MainLoginState();
}

class MainLoginState extends State<MainLogin> {

  GlobalState _store = GlobalState.instance;

  static String className = "[MainLoginState]";
  static String classNameKey = "MainLoginState";
  static String title = MyApp.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = MyApp.EMPTY;

  static String line1 = "Welcome To";
  static String line2 = title;

  // TODO: Sample logging message
  /*
  logMsg = "[Placeholder]";
  developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
  */

  @override
  void initState() {
    super.initState();
    _store.set(classNameKey, className);
    title = _store.get(MyApp.titleKey);
    sequenceNumber = _store.get(MyApp.sequenceNumberKey);
    sequenceNumber++;
    _store.set(MyApp.sequenceNumberKey, sequenceNumber);
  }

  @override
  Widget build(BuildContext context) {
    logMsg = "build(BuildContext context) called.\n" +
        MyApp.sequenceNumberKey + ": " + sequenceNumber.toString();
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    return Scaffold(
      backgroundColor: MyAppColors.blue2,
      body: new Container(
        padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 50.0),
        alignment: Alignment.topCenter,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: MyAppTheme.titleTheme().textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}