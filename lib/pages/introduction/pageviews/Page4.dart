import 'package:flutter/material.dart';
import 'package:revire/pages/introduction/MyHomePage.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'dart:developer' as developer;

class Page4 {
  static String className = "[Page4]";
  static String title = "ReviRe";
  static int sequenceNumber = -1;
  static String logMsg = "EMPTY";

  static String line1 = "At " + title + ", we take your privacy and security seriously.";

  Page4(String _title, int _sequenceNumber) {
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
