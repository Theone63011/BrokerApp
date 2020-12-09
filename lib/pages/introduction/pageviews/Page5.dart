import 'package:flutter/material.dart';
import 'package:startup_app/pages/introduction/MyHomePage.dart';
import 'package:startup_app/theme/MyAppTheme.dart';
import 'package:startup_app/theme/MyAppColors.dart';
import 'package:startup_app/LogLevels.dart';
import 'dart:developer' as developer;

class Page5 {
  static String className = "[Page5]";
  static String title = "ReviRe";
  static int sequenceNumber = -1;
  static String logMsg = "EMPTY";

  static String line1 = "To make sure your buying or selling experience is safe and secure, we have implemented\n";
  static String line2 = "- Multi-factor authentication\n- Active threat detection & prevention\n- Crypto agility\n";
  static String line3 = "and many more top level security protocols.";


  Page5(String _title, int _sequenceNumber) {
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
            Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Text(
                      line1,
                      style: MyAppTheme.data().textTheme.headline4,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                    Text(
                      line2,
                      style: MyAppTheme.data().textTheme.headline5,
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                    Text(
                      line3,
                      style: MyAppTheme.data().textTheme.headline4,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
