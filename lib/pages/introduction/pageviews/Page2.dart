import 'package:flutter/material.dart';
import 'package:revire/main.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/pages/introduction/pageviews/Page3.dart';
import 'dart:developer' as developer;

class Page2 extends StatefulWidget {
  Page2({Key key}) : super(key: key);

  @override
  Page2State createState() => new Page2State();
}


class Page2State extends State<Page2> {

  GlobalState _store = GlobalState.instance;
  static String className = "[Page2State]";
  static String classNameKey = "Page2State";
  static String title = MyApp.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = MyApp.EMPTY;

  static String line1 = title + " is your \nall-in-one real estate experience,\nfrom the palm of your hand.";

  @override
  void initState() {
    super.initState();
    _store.set(classNameKey, className);
    title = _store.get(MyApp.titleKey);
    sequenceNumber = _store.get(MyApp.sequenceNumberKey);
    sequenceNumber++;
    _store.set(MyApp.sequenceNumberKey, sequenceNumber);
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
