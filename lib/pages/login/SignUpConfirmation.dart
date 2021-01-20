import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:revire/widgets/NumberPad.dart';

class SignUpConfirmation extends StatefulWidget {
  SignUpConfirmation({Key key}) : super(key: key);

  @override
  SignUpConfirmationState createState() => new SignUpConfirmationState();
}

class SignUpConfirmationState extends State<SignUpConfirmation> {
  GlobalState _store = GlobalState.instance;
  static String className = (SignUpConfirmationState).toString();
  static Logging log = new Logging(className);
  static bool errorFound;
  String enteredCode = "";
  static LoginData data;

  int uniqueCodeLength = 6;
  double codeNumberFontSize = 20.0;

  @override
  void initState() {
    super.initState();
    log.info("initState() called.");
    errorFound = checkInitialState();
    data = _store.get(Constants.loginDataKey);
  }

  bool checkInitialState() {
    log.info("checkInitialState() called.");
    bool loggedIn = _store.get(Constants.loginCompleteKey);
    bool signedUp = _store.get(Constants.signUpCompleteKey);

    if (loggedIn || signedUp) {
      log.error("ERROR- The global store indicates that:\n" + "loggedIn = " +
          loggedIn.toString() + ", and signedUp = " + signedUp.toString() + ".\nThis SHOULD NOT HAPPEN!");
      Constants.showDialog_CloseOption(context, "Confirmation Error!", "ERROR- The global store indicates that:\n" +
          "loggedIn = " + loggedIn.toString() + ", and signedUp = " + signedUp.toString() + ".\nThis SHOULD NOT HAPPEN!");
      return true;
    } else {
      return false;
    }
  }

  void confirmSignUp(BuildContext context) async {
    log.info("confirmSignUp(BuildContext context) called.");
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(username: data.name, confirmationCode: enteredCode);
      log.info("Confirm sign up Successful!");
      _store.set(Constants.signUpCompleteKey, true);
      Navigator.pop(context);
    } on AuthError catch (error) {
      log.error("Confirm sign up FAILED! error- " + error.toString());
      setState(() {
        enteredCode = "";
      });
    }
  }

  void resendCode(BuildContext context) async {
    log.info("resendCode(BuildContext context) called.");
    try {
      ResendSignUpCodeResult res = await Amplify.Auth.resendSignUpCode(username: data.name);
      log.info("Resend sign up code Successful!");
      setState(() {
        enteredCode = "";
      });
    } on AuthError catch (error) {
      log.error("Resend sign up code FAILED! error- " + error.toString());
      Constants.showDialog_CloseOption(context, "Resend sign up code failed!", "ERROR! Failed to resend new sign up "
          "code- THIS SHOULD NOT HAPPEN!");
    }
  }

  Widget buildCodeNumberBox(String codeNumber, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: ((MediaQuery.of(context).size.width - 100) / uniqueCodeLength),
        height: ((MediaQuery.of(context).size.width - 100) / uniqueCodeLength),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 1,
                offset: Offset(0.0, 0.75),
              ),
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: codeNumberFontSize,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log.info("build(BuildContext context) called.");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Sign Up Confirmation",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: Text(
                        "Please check your email for code",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          color: Color(0xFF818181),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildCodeNumberBox(enteredCode.length > 0 ? enteredCode.substring(0, 1) : "", context),
                          buildCodeNumberBox(enteredCode.length > 1 ? enteredCode.substring(1, 2) : "", context),
                          buildCodeNumberBox(enteredCode.length > 2 ? enteredCode.substring(2, 3) : "", context),
                          buildCodeNumberBox(enteredCode.length > 3 ? enteredCode.substring(3, 4) : "", context),
                          buildCodeNumberBox(enteredCode.length > 4 ? enteredCode.substring(4, 5) : "", context),
                          buildCodeNumberBox(enteredCode.length > 5 ? enteredCode.substring(5, 6) : "", context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Didn't recieve code? ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF818181),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              log.info("\"Request new code\" button pressed.");
                              resendCode(context);
                            },
                            child: Text(
                              "Request again",
                              style: TextStyle(
                                fontSize: 18,
                                color: MyAppColors.bluegreen1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          log.info("\"Confirm Sign Up\" button pressed.");
                          confirmSignUp(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyAppColors.blue2,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              "Confirm Sign Up",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            NumberPad(
              onNumberSelected: (value) {
                log.info("Number selected: " + value.toString());
                setState(() {
                  if(value != -1) {
                    if(enteredCode.length < uniqueCodeLength){
                      enteredCode = enteredCode + value.toString();
                    } else {
                      log.warn("Max entered code length reached.");
                    }
                  } else if(enteredCode.length == 0) {
                    log.warn("enteredCode length is already 0 and cannot be reduced anymore.");
                  }
                  else {
                    enteredCode = enteredCode.substring(0, enteredCode.length - 1);
                  }
                  log.info("enteredCode= " + enteredCode);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}















