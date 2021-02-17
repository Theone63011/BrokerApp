import 'dart:math';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:revire/pages/login/SignUpConfirmation.dart';
import 'package:revire/pages/introduction/HomePage.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/services.dart';

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
    _store.set(Constants.loginCompleteKey, false);
    _store.set(Constants.signUpConfirmedKey, false);
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
          AuthUser user = await Amplify.Auth.getCurrentUser();
          String username = user.username;
          String userid = user.userId;
          String name = data.name;

          String securedUserId = Constants.getSecuredString(userid);
          String securedUserName = Constants.getSecuredString(username);
          String securedName = Constants.getSecuredString(name);
          if (securedName == null || securedUserName == null || securedUserId == null) {
            log.error("ERROR- one of the secured user details is null- THIS SHOULD NOT HAPPEN!\n\tsecuredUserId= " +
                securedUserId + "\n\tsecuredUserName= " + securedUserName + "\n\tsecuredName= " + securedName);
            return "Login Failed!";
          }

          _store.set(Constants.userNameKey, username);
          _store.set(Constants.nameKey, name);
          _store.set(Constants.userIdKey, userid);
          _store.set(Constants.loginCompleteKey, true);
          _store.set(Constants.signUpConfirmedKey, true);


          log.info("User login complete.\n");
//              "Logged in User details:" +
//              "\n\tNON-SECURED UserId= " + userid +
//              "\n\tSECURED UserId= " + securedUserId +
//              "\n\tNON-SECURED UserName= " + username +
//              "\n\tSECURED UserName= " + securedUserName +
//              "\n\tNON-SECURED UserEmail= " + useremail +
//              "\n\tSECURED UserEmail= " + securedUserEmail);
          return null;
        } else {
          log.warn("Login FAILED. SignInResult: \n" + res.toString() + "\n");
          _store.set(Constants.loginCompleteKey, false);
          Constants.showDialog_UnexpectedError(context);
          return "Login Failed!";
        }
      //});
    } on AuthException catch (error) {
      String errorMessage = error.message;
      String underlyingException = error.underlyingException;
      String rawError = error.toString();
      log.error("Error message: " + errorMessage);
      log.error("Underlying Exception: " + underlyingException);
      log.error("Raw error: " + rawError);
      /*List<AuthException> exceptions = error;
      String ret = "Login Failed!";
      log.error("Login FAILED! AuthError caught. Auth Exceptions:\n");
      exceptions.forEach((element) {
        log.error("\t" + element.exception + " Exception- " + element.detail.toString());
        if (element.exception == 'AMAZON_CLIENT_EXCEPTION') {
          String message = element.detail.toString().substring(0, element.detail.toString().indexOf("(")) + "\nPlease sign up a new account.";
          ret = message;
        }
        if (element.exception == 'NOT_AUTHORIZED') {
          log.error("NOT_AUTHORIZED processing...");
          String message = element.detail.toString();
          ret = message;
        }
      });
      return ret;*/
    }
  }

  //TODO- group this function in with the SignUpConfirmation class- so as to NOT store logindata for security reasons
  Future<String> signUp(LoginData data) async {
    log.info("signUp(LoginData data) called.");
    _store.set(Constants.loginDataKey, data);
    try {
      //TODO- Add more user attributes here- like phone #, address, etc.
      Map<String, dynamic> userAttributes = {
        "email": data.name,
      };
      SignUpResult res = await Amplify.Auth.signUp(username: data.name, password: data.password, options:
      CognitoSignUpOptions(userAttributes: userAttributes));
      //setState(() {
      bool signUpComplete = res.isSignUpComplete;
      _store.set(Constants.signUpConfirmedKey, false);
      if (signUpComplete) {
        log.info("Sign Up Complete.");
        return null;
      } else {
        log.warn("Sign up FAILED. result: " + res.toString());
        return "Sign up FAILED!";
      }
      //});
    } on AuthException catch (error) {
      /*List<AuthException> exceptions = error.exceptionList;
      log.error("Sign up Failed! AuthError caught. Auth Exceptions:\n");
      exceptions.forEach((element) {
        log.error("\t" + element.exception + " Exception- " + element.detail.toString());
        if (element.exception == 'USER_NOT_CONFIRMED') {
          String message = element.detail.toString() + "\nPlease check email for confirmation code.";
          Constants.showDialog_OkayOption(context, "Sign up Failed!", message);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpConfirmation()),
          );
        } else if(element.exception == 'USERNAME_EXISTS') {
          String message = element.detail.toString() + "\nPlease try logging in.";
          Constants.showDialog_OkayOption(context, "Sign up Failed!", message);
        }
      });*/
    }
    return "Sign up Failed!";
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
      onLogin: (loginData) {
        return login(loginData);
      },
      onSignup: (loginData) {
        return signUp(loginData);
      },
      title: Constants.title,
      emailValidator: (value) {
        return validateEmail(value);
      },
      onSubmitAnimationCompleted: () {
        if(_store.get(Constants.signUpConfirmedKey) == false) {
          log.warn("Sign Up Confirmed key is false- re-trying confirmation process...");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpConfirmation()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
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
      theme: LoginTheme(
         primaryColor: Colors.blue,
         accentColor: Colors.teal,
         errorColor: Colors.orange,
         titleStyle: TextStyle(
           color: Colors.white,
           fontFamily: 'Quicksand',
           letterSpacing: 4,
         ),
         beforeHeroFontSize: 50,
         afterHeroFontSize: 50,
         bodyStyle: TextStyle(
           fontStyle: FontStyle.italic,
           decoration: TextDecoration.underline,
         ),
         textFieldStyle: TextStyle(
           color: Colors.teal,
           //shadows: [Shadow(color: Colors.black, blurRadius: 10)],
         ),
         buttonStyle: TextStyle(
           fontWeight: FontWeight.w800,
           color: Colors.white,
         ),
         cardTheme: CardTheme(
           color: Colors.white,
           elevation: 5,
           margin: EdgeInsets.only(top: 15),
           shape: ContinuousRectangleBorder(
               borderRadius: BorderRadius.circular(100.0)),
         ),
         inputTheme: InputDecorationTheme(
           filled: true,
           fillColor: Colors.black.withOpacity(.2),
           contentPadding: EdgeInsets.zero,
           errorStyle: TextStyle(
             backgroundColor: Colors.white,
             color: Colors.white,
           ),
           labelStyle: TextStyle(fontSize: 15),
           enabledBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
             borderRadius: inputBorder,
           ),
           focusedBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
             borderRadius: inputBorder,
           ),
           errorBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.red.shade700, width: 7),
             borderRadius: inputBorder,
           ),
           focusedErrorBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.red.shade400, width: 8),
             borderRadius: inputBorder,
           ),
           disabledBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.grey, width: 5),
             borderRadius: inputBorder,
           ),
         ),
         buttonTheme: LoginButtonTheme(
           splashColor: Colors.teal,
           backgroundColor: Colors.teal,
           highlightColor: Colors.teal,
           elevation: 9.0,
           highlightElevation: 6.0,
           //shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10),),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
           //shape: CircleBorder(side: BorderSide(color: Colors.green)),
           //shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
         ),
      ),
    );


      /*Scaffold(
      backgroundColor: Colors.blue2,
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
                            Colors.blue1,
                            Colors.bluegreen1  ,
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
                            Colors.blue1,
                            Colors.bluegreen1  ,
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