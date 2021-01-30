import 'dart:io';
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
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:device_info/device_info.dart';

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
    bool signedUp = _store.get(Constants.signUpConfirmedKey);

    if (loggedIn || signedUp) {
      log.error("ERROR- The global store indicates that:\n" +
          "loggedIn = " +
          loggedIn.toString() +
          ", and signedUp = " +
          signedUp.toString() +
          ".\nThis SHOULD NOT HAPPEN!");
      Constants.showDialog_CloseOption(
          context,
          "Confirmation Error!",
          "ERROR- The global store indicates that:\n" +
              "loggedIn = " +
              loggedIn.toString() +
              ", and signedUp = " +
              signedUp.toString() +
              ".\nThis SHOULD NOT HAPPEN!");
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, String>> getDeviceDetails() async {
    log.info("getDeviceDetails() called.");

    //TODO: SECURITY WARNING:
    //    With a rooted phone, some of these values could be incorrect or misrepresented.
    //    Consider adding additional security here.

    //TODO: When adding web support, this needs to be updated.

    String device;
    String deviceName;
    String deviceVersion;
    String deviceId;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;
        device = deviceInfo.device;
        deviceName = deviceInfo.model;
        AndroidBuildVersion buildVersion = deviceInfo.version;
        deviceVersion = buildVersion.release;
        deviceId = deviceInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo deviceInfo = await deviceInfoPlugin.iosInfo;
        device = deviceInfo.name;
        deviceName = deviceInfo.model;
        deviceVersion = deviceInfo.systemVersion;
        deviceId = deviceInfo.identifierForVendor;
      } else {
        log.error("ERROR! Platform found is NEITHER Android OR IOS.");
        return null;
      }
    } catch (error) {
      log.error("ERROR! Could not get device details from 'DeviceInfoPlugin'.");
      return null;
    }

    _store.set(Constants.deviceKey, device);
    _store.set(Constants.deviceNameKey, deviceName);
    _store.set(Constants.deviceVersionKey, deviceVersion);
    _store.set(Constants.deviceIdKey, deviceId);

    final Map<String, String> deviceDetails = {
      "device":device,
      "deviceName":deviceName,
      "deviceVersion":deviceVersion,
      "deviceId":deviceId,
    };
    return deviceDetails;
  }

  Future<bool> confirmDevice(BuildContext context) async {
    log.info("confirmDevice(BuildContext context) called.");
    data = _store.get(Constants.loginDataKey);
    if (data.name == null) {
      log.error("data.name is null. THIS SHOULD NOT HAPPEN");
      Constants.showDialog_UnexpectedError(context);
      Navigator.pop(context);
    }

    Map<String, String> deviceDetails = await getDeviceDetails();
    log.info("Device Details: ");
    deviceDetails.forEach((key, value) {
      log.info(key + ": " + value);
    });

    try {
      AuthUser user = await Amplify.Auth.getCurrentUser();
      String userId = user.userId;
      String username = user.username;


      //TODO - add 'remembered device' feature for Android/IOS specific code:
      //TODO For Android: https://docs.amplify.aws/lib/auth/device_features/q/platform/android
      //TODO For IOS: https://docs.amplify.aws/lib/auth/device_features/q/platform/ios

      

    } on AuthError catch (error) {

    }

    return Future.value(false);
  }

  void confirmSignUp(BuildContext context) async {
    log.info("confirmSignUp(BuildContext context) called.");
    data = _store.get(Constants.loginDataKey);
    if (data.name == null) {
      log.error("data.name is null. THIS SHOULD NOT HAPPEN");
      Constants.showDialog_UnexpectedError(context);
      Navigator.pop(context);
    }
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(username: data.name, confirmationCode: enteredCode);
      if (res.isSignUpComplete) {
        log.info("Confirm sign up Successful!");
        _store.set(Constants.signUpConfirmedKey, true);
        bool deviceConfirmationResult = await confirmDevice(context);
        if (deviceConfirmationResult) {
          log.info("Device confirmation successful.");
          //TODO- continue to home page
          Constants.showInProgressDialog(context);
        } else {
          log.error("ERROR! Device confirmation FAILED.");
          //TODO- what happens if the device cannot be confirmed?
        }
      } else {
        log.error("Sign up incomplete! result: " + res.toString());
        Constants.showDialog_UnexpectedError(context);
        _store.set(Constants.signUpConfirmedKey, false);
        Navigator.pop(context);
      }
    } on AuthError catch (error) {
      List<AuthException> exceptions = error.exceptionList;
      log.error("Email Confirmation FAILED! AuthError caught. Auth Exceptions:\n");
      exceptions.forEach((element) {
        log.error("\t" + element.exception + " Exception- " + element.detail.toString());
        if (element.exception == 'CODE_MISMATCH') {
          String message = element.detail.toString();
          Constants.showDialog_OkayOption(context, "Sign up Failed!", message);
          log.info("CODE_MISMATCH error handling complete.");
        }
      });
      setState(() {
        _store.set(Constants.signUpConfirmedKey, false);
        enteredCode = "";
      });
    }
  }

  void resendCode(BuildContext context) async {
    log.info("resendCode(BuildContext context) called.");
    data = _store.get(Constants.loginDataKey);
    if (data.name == null) {
      log.error("data.name is null. THIS SHOULD NOT HAPPEN");
      Constants.showDialog_UnexpectedError(context);
      Navigator.pop(context);
    }
    try {
      ResendSignUpCodeResult res = await Amplify.Auth.resendSignUpCode(username: data.name);
      log.info("Resend sign up code Successful!");
      Constants.showDialog_OkayOption(
          context,
          "New Confirmation Code",
          "A new confirmation code has be sent to the "
              "email associated with the account. Please enter code to verify account.");
      setState(() {
        enteredCode = "";
      });
    } on AuthError catch (error) {
      log.error("Resend sign up code FAILED! THIS SHOULD NOT HAPPEN! error- " + error.toString());
      Constants.showDialog_UnexpectedError(context);
      Navigator.pop(context);
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

    final snackBar = SnackBar(
      content: Text("DEBUG: Back button is disabled."),
      /*action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          log.info("SnackBar pressed.");
        },
      ),*/
    );

    return WillPopScope(
      onWillPop: () {
        //Scaffold.of(context).showSnackBar(snackBar);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          /*leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),*/
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
                    if (value != -1) {
                      if (enteredCode.length < uniqueCodeLength) {
                        enteredCode = enteredCode + value.toString();
                      } else {
                        log.warn("Max entered code length reached.");
                      }
                    } else if (enteredCode.length == 0) {
                      log.warn("enteredCode length is already 0 and cannot be reduced anymore.");
                    } else {
                      enteredCode = enteredCode.substring(0, enteredCode.length - 1);
                    }
                    log.info("enteredCode= " + enteredCode);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
