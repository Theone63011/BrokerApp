import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/main.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/pages/introduction/pageviews/Page7.dart';
import 'dart:developer' as developer;

class Page6 extends StatefulWidget {
  Page6({Key key}) : super(key: key);

  @override
  Page6State createState() => new Page6State();
}

class Page6State extends State<Page6> {

  GlobalState _store = GlobalState.instance;
  static String className = "[Page6State]";
  static String classNameKey = "Page6State";
  static String title = MyApp.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = MyApp.EMPTY;

  static String line1 = "We hope that your experience with " + title + " is as valuable as the memories made in your "
      "home.";
  static String line2 = "\n\n\n\n\n\n- sincerely";
  static String line3 = "The " + title + " Team";

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
        //padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              line1,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .headline3,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            Text(
              line2,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .bodyText1,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            Text(
              line3,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .bodyText1,
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: MyAppColors.green1,
        onPressed: () {
          logMsg = "onPressed() called.\n" +
              MyApp.sequenceNumberKey + ": " + sequenceNumber.toString();
          developer.log(
              className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page7()),
          );
        },
      ),
    );
  }
}
