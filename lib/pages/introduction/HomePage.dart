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
import 'package:revire/pages/login/MainLogin.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  GlobalState _store = GlobalState.instance;
  static String className = (HomePageState).toString();
  static Logging log = new Logging(className);

  @override
  void initState() {
    super.initState();
    log.info("initState() called.");
  }

  Future<bool> checkLoginState(BuildContext context) async{
    log.info("checkInitialState() called.");
    bool loggedIn = _store.get(Constants.loginCompleteKey);
    bool signedUp = _store.get(Constants.signUpConfirmedKey);
    String userName = _store.get(Constants.userNameKey);
    String userId = _store.get(Constants.userIdKey);

    if (loggedIn == null || signedUp == null || userName == null || userId == null) {
      String errormessage = "ERROR! Login state failed. Values:" +
          "\n\tloggedIn = " + loggedIn.toString() +
          "\n\tsignedUp = " + signedUp.toString() +
          "\n\tuserName = " + userName +
          "\n\tuserId = " + userId;
      log.error(errormessage);
      await Constants.showDialog_UnexpectedError(context);
      return Future.value(false);
    } else {
      log.info("checkLoginState passed.");
      return Future.value(true);
    }
  }

  Future<bool> showLogOutDialog(BuildContext context) {
    return showDialog(
        context: null,
        builder: (BuildContext context) {
          return AlertDialog (
            title: Text('Logging Out'),
            content: Text('Do you really want to log out?'),
            actions: [
              FlatButton(
                child: Text('Yes'),
                onPressed: () =>
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainLogin()),
                    ),
                //Navigator.pop(c, true),
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    log.info("build(BuildContext context) called.");

    //TODO- check error state
    checkLoginState(context);
    /*if(checkLoginState(context) == false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainLogin()),
      );
      return null;
    }*/

    /*final snackBar = SnackBar(
      content: Text("DEBUG: Back button is disabled."),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          log.info("SnackBar pressed.");
        },
      ),
    );*/

    return WillPopScope(
      onWillPop: () => showLogOutDialog(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              log.info("HomePage menu selected.");
              //Navigator.pop(context);
            },
            child: Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: Text(
            Constants.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: MyAppColors.blue2,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Welcome to " + Constants.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: MyAppColors.blue2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
