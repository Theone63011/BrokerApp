import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/pages/login/MainLogin.dart';

class MainSignUp extends StatefulWidget {
  MainSignUp({Key key}) : super(key: key);

  @override
  MainSignUpState createState() => new MainSignUpState();
}

class MainSignUpState extends State<MainSignUp> {
  static String className = (MainSignUpState).toString();
  static Logging log = new Logging(className);

  static String loginText = "Login";
  static String signUpText = "Sign up";

  @override
  void initState() {
    super.initState();
    log.info("initState() called.");
  }

  @override
  Widget build(BuildContext context) {
    log.info("build(BuildContext context) called.");
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
                Constants.title,
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