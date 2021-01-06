import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revire/main.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/constants/Constants.dart';
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
  static String title = Constants.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = Constants.EMPTY;

  static String loginText = "Login";
  static String signUpText = "Sign up";

  @override
  void initState() {
    super.initState();
    _store.set(classNameKey, className);
    title = _store.get(Constants.titleKey);
    sequenceNumber = _store.get(Constants.sequenceNumberKey);
    sequenceNumber++;
    _store.set(Constants.sequenceNumberKey, sequenceNumber);
  }

  double getTitleDistanceFromTop(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.25;
  }

  double getButtonBarDistanceFromBottom(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.15;
  }

  @override
  Widget build(BuildContext context) {
    logMsg = "build(BuildContext context) called.\n" +
        Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    return Scaffold(
      backgroundColor: MyAppColors.blue2,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                10.0,
                getTitleDistanceFromTop(context),
                10.0,
                10.0
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child:
              Text(
                title,
                style: MyAppTheme.titleTheme().textTheme.headline1,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                10.0,
                10.0,
                10.0,
                getButtonBarDistanceFromBottom(context),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ButtonBar(
                mainAxisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //SizedBox(height: 50),
                  RaisedButton(
                    onPressed: () {
                      logMsg = "onPressed() called.\n" +
                          Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
                      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

                      Constants.showInProgressDialog(context);
                    },
                    textColor: Colors.white,
                    padding: EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            MyAppColors.blue1,
                            MyAppColors.bluegreen1  ,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      child: Text(loginText, style: MyAppTheme.data().textTheme.headline3),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      logMsg = "onPressed() called.\n" +
                          Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
                      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

                      Constants.showInProgressDialog(context);
                    },
                    textColor: Colors.white,
                    padding: EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            MyAppColors.blue1,
                            MyAppColors.bluegreen1  ,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      child: Text(signUpText, style: MyAppTheme.data().textTheme.headline3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}