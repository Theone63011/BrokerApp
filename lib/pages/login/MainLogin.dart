import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:revire/pages/introduction/MyHomePage.dart';

class MainLogin extends StatefulWidget {
  MainLogin({Key key}) : super(key: key);

  @override
  MainLoginState createState() => new MainLoginState();
}

class MainLoginState extends State<MainLogin> {

  GlobalState _store = GlobalState.instance;
  static String className = (MainLoginState).toString();
  static Logging log = new Logging(className);

  static String loginText = "Login";
  static String signUpText = "Sign up";
  static String validationPassed = "Validation Passed";
  static String validationFailed = "Validation Failed";

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  @override
  void initState() {
    super.initState();
    log.info("initState() called.");
    _store.set(Constants.signUpCompleteKey, false);
    _store.set(Constants.loginCompleteKey, false);
  }

  static double getTitleDistanceFromTop(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.25;
  }

  double getButtonBarDistanceFromBottom(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.15;
  }

  Future<String> login(LoginData data) async {
    log.info("login(LoginData data) called.");

    try {
      SignInResult res = await Amplify.Auth.signIn(username: data.name, password: data.password);

      //Todo- check if user actually exists in DB

      //Todo- check if user password actually matches the data.password

      //setState(() {
        bool loginComplete = res.isSignedIn;

        if(loginComplete) {
          log.info("\t Login Complete.");
          _store.set(Constants.loginCompleteKey, true);
          return null;
        } else {
          log.warn("Login FAILED. SignInResult: \n" + res.toString() + "\n");
          _store.set(Constants.loginCompleteKey, false);
          return "Login FAILED";
        }
      //});
    } catch (error) {
      log.error("exception caught in [login(LoginData data)] - \n" + error.toString() + "\n");
      return "Login Failed! Exception caught-\n" + error.toString();
    }
  }

  Future<String> signUp(LoginData data) async {
    log.info("signUp(LoginData data) called.");
    try {

      //TODO- Add more user attributes here- like phone #, address, etc.
      Map<String, dynamic> userAttributes = {
        "email" : data.name,
      };
      SignUpResult res = await Amplify.Auth.signUp(username: data.name, password: data.password, options:
      CognitoSignUpOptions(userAttributes: userAttributes));
      //setState(() {
        bool signUpComplete = res.isSignUpComplete;

        if(signUpComplete) {
          log.info("Sign Up Complete.");
          _store.set(Constants.signUpCompleteKey, true);
          return null;
        } else {
          log.warn("Sign up FAILED.");
          _store.set(Constants.signUpCompleteKey, false);
          return "Sign up FAILED";
        }
      //});
    } on AuthError catch (error) {
      log.error("exception caught in [signUp] - \n" + error.toString() + "\n");
      return "Sign up FAILED! Exception caught-\n" + error.toString();
    }
  }

  String validateEmail (String value) {
    log.info("validateEmail(String value) called.");

    //Todo- make this more secure

    bool valid;
    String errorMsg = null;
    if (value.contains('@')) {
      valid = true;
    } else {
      errorMsg = "Given email does not contain an @ symbol.";
      log.warn(errorMsg);
      valid = false;
    }

    return errorMsg;
  }

  @override
  Widget build(BuildContext context) {
    log.info("build(BuildContext context) called.");

    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      logo: "assets/images/baseline_home_work_black_18dp.png",
      onLogin: login,
      onSignup: signUp,
      title: Constants.title,
      emailValidator: (value) {
        return validateEmail(value);
      },
      onSubmitAnimationCompleted: () {
        Constants.showInProgressDialog(context);
        //Navigator.push(
        //  context,
        //  MaterialPageRoute(builder: (context) => MyHomePage()),
        //);
      },
      onRecoverPassword: (name) {
        Constants.showInProgressDialog(context);
        return null;
      },
      //messages: LoginMessages(
      //   usernameHint: 'Username',
      //   passwordHint: 'Pass',
      //   confirmPasswordHint: 'Confirm',
      //   loginButton: 'Login',
      //   signupButton: 'Sign Up',
      //   forgotPasswordButton: 'Forgot password?',
      //   recoverPasswordButton: 'HELP ME',
      //   goBackButton: 'GO BACK',
      //   confirmPasswordError: 'Not match!',
      //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
      //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      //   recoverPasswordSuccess: 'Password rescued successfully',
      //),
      //theme: LoginTheme(
      //   primaryColor: MyAppColors.blue2,
      //   accentColor: MyAppColors.bluegreen1,
      //   errorColor: Colors.deepOrange,
      //   titleStyle: TextStyle(
      //     color: Colors.white,
      //     fontFamily: 'Quicksand',
      //     letterSpacing: 4,
      //   ),
      //   // beforeHeroFontSize: 50,
      //   // afterHeroFontSize: 20,
      //   bodyStyle: TextStyle(
      //     fontStyle: FontStyle.italic,
      //     decoration: TextDecoration.underline,
      //   ),
      //   textFieldStyle: TextStyle(
      //     color: Colors.orange,
      //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
      //   ),
      //   buttonStyle: TextStyle(
      //     fontWeight: FontWeight.w800,
      //     color: Colors.yellow,
      //   ),
      //   cardTheme: CardTheme(
      //     color: Colors.yellow.shade100,
      //     elevation: 5,
      //     margin: EdgeInsets.only(top: 15),
      //     shape: ContinuousRectangleBorder(
      //         borderRadius: BorderRadius.circular(100.0)),
      //   ),
      //   inputTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Colors.purple.withOpacity(.1),
      //     contentPadding: EdgeInsets.zero,
      //     errorStyle: TextStyle(
      //       backgroundColor: Colors.orange,
      //       color: Colors.white,
      //     ),
      //     labelStyle: TextStyle(fontSize: 12),
      //     enabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //     errorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedErrorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
      //       borderRadius: inputBorder,
      //     ),
      //     disabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.grey, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //   ),
      //   buttonTheme: LoginButtonTheme(
      //     splashColor: Colors.purple,
      //     backgroundColor: Colors.pinkAccent,
      //     highlightColor: Colors.lightGreen,
      //     elevation: 9.0,
      //     highlightElevation: 6.0,
      //     shape: BeveledRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
      //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
      //   ),
      //),
    );


      /*Scaffold(
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
                Constants.title,
                style: MyAppTheme.titleTheme().textTheme.headline1,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                10.0,
                getTitleDistanceFromTop(context) * 2,
                10.0,
                10.0,
            ),
            child: Align (
              alignment: Alignment.topCenter,
              child: SafeArea(
                child:
              ),
            ),
          ),*/

          /*Padding(
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

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainSignUp()),
                      );*/
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
    );*/
  }
}