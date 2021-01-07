import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revire/main.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/pages/login/MainLogin.dart';
import 'dart:developer' as developer;

class MainSignUp extends StatefulWidget {
  MainSignUp({Key key}) : super(key: key);

  @override
  MainSignUpState createState() => new MainSignUpState();
}

class MainSignUpState extends State<MainSignUp> {

  GlobalState _store = GlobalState.instance;

  static String className = "[MainSignUpState]";
  static String classNameKey = "MainSignUpState";
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
                MainLoginState.getTitleDistanceFromTop(context),
                10.0,
                10.0,
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
        ],
      ),
    );
  }
}