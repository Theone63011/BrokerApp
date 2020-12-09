import 'package:flutter/material.dart';
import 'package:startup_app/pages/introduction/MyHomePage.dart';
import 'package:startup_app/theme/MyAppTheme.dart';
import 'package:startup_app/theme/MyAppColors.dart';
import 'package:startup_app/LogLevels.dart';
import 'dart:developer' as developer;

class Page2 {
  static String className = "[Page2]";
  static String title = "ReviRe";
  static int sequenceNumber = -1;
  static String logMsg = "EMPTY";

  static String line1 = title + " is your \nall-in-one real estate experience,\nfrom the palm of your hand.";

  Page2(String _title, int _sequenceNumber) {
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
                    style: MyAppTheme.data().textTheme.headline3,
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
