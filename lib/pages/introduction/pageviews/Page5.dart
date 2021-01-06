import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/main.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/pages/introduction/pageviews/Page6.dart';
import 'dart:developer' as developer;

class Page5 extends StatefulWidget {
  Page5({Key key}) : super(key: key);

  @override
  Page5State createState() => new Page5State();
}

class Page5State extends State<Page5> {

  GlobalState _store = GlobalState.instance;
  static String className = "[Page5State]";
  static String classNameKey = "Page5State";
  static String title = Constants.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = Constants.EMPTY;

  static String line1 = "To make sure your buying or selling experience is safe and secure, we have implemented\n";
  static String line2 = "- Multi-factor authentication\n- Active threat detection & prevention\n- Crypto agility\n";
  static String line3 = "and many more top level security protocols.";

  @override
  void initState() {
    super.initState();
    _store.set(classNameKey, className);
    title = _store.get(Constants.titleKey);
    sequenceNumber = _store.get(Constants.sequenceNumberKey);
    sequenceNumber++;
    _store.set(Constants.sequenceNumberKey, sequenceNumber);
  }

  @override
  Widget build(BuildContext context) {
    logMsg = "build(BuildContext context) called.\n" +
        Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
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
                  .headline4,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            Text(
              line2,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .headline5,
              textAlign: TextAlign.left,
              softWrap: true,
            ),
            Text(
              line3,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .headline4,
              textAlign: TextAlign.center,
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
              Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
          developer.log(
              className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page6()),
          );
        },
      ),
    );
  }
}
