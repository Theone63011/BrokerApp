import 'package:flutter/material.dart';
import 'package:startup_app/pages/introduction/MyHomePage.dart';
import 'package:startup_app/theme/MyAppTheme.dart';
import 'package:startup_app/theme/MyAppColors.dart';
import 'package:startup_app/LogLevels.dart';
import 'dart:developer' as developer;

class Page1 {
  static String className = "[Page1]";
  static String title = "ReviRe";
  static int sequenceNumber = -1;
  static String logMsg = "EMPTY";

  static String line1 = "Welcome To";
  static String line2 = title;

  Page1(String _title, int _sequenceNumber) {
    sequenceNumber = _sequenceNumber + 1;
    logMsg = "Constructor called";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
    title = _title;
  }

  static Widget data() {
    logMsg = "data() called.";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    return Scaffold(
      backgroundColor: MyAppColors.blue2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              line1,
              style: MyAppTheme.data().textTheme.headline2,
            ),
            Text(
              line2,
              style: MyAppTheme.data().textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}