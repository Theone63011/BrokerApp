import 'package:flutter/material.dart';
import 'package:revire/pages/login/MainLogin.dart';
import 'package:revire/constants/GlobalState.dart';
import 'dart:math';

class Constants {

  static const String title = "ReviRE";
  static const String titleKey = "title";
  static const String selectedUserTypeKey = "selectedUserType";
  static const String buyerSellerType = "buyerSeller";
  static const String buyerSellerString = "Buyer/Seller";
  static const String brokerAgentType = "brokerAgent";
  static const String brokerAgentString = "Broker/Agent";
  static const String sequenceNumberKey = "sequenceNumber";
  static final String NOTSET = "NOTSET";
  static final String EMPTY = "EMPTY";
  static final String signUpConfirmedKey = "signUpConfirmed";
  static final String loginCompleteKey = "loginComplete";
  //TODO- remove the storage of logindata as this poses a security risk
  static final String loginDataKey = "loginData";
  //TODO- all the credentials below should be 'secured'
  static final String deviceKey = "device";
  static final String deviceNameKey = "deviceName";
  static final String deviceVersionKey = "deviceVersion";
  static final String deviceIdKey = "deviceId";
  static final String userNameKey = "userName";
  static final String nameKey = "name";
  static final String userIdKey = "userId";

  static GlobalState _store = GlobalState.instance;

  static int incrementSequenceNumber() {
    int sequenceNumber = _store.get(sequenceNumberKey);
    sequenceNumber++;
    _store.set(sequenceNumberKey, sequenceNumber);
    return sequenceNumber;
  }

  static void showInProgressDialog(BuildContext context) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog (
            title: new Text("Feature in progress..."),
            content: new Text("WARNING- This feature is still in progress and is disabled.\nNormal usage should still "
                "work as expected."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  static void showDialog_CloseOption(BuildContext context, String title, String body) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog (
            title: new Text(title),
            content: new Text(body),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  static void showDialog_OkayOption(BuildContext context, String title, String body) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog (
            title: new Text(title),
            content: new Text(body),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  static void showDialog_UnexpectedError(BuildContext context) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog (
            title: new Text("System Error"),
            content: new Text("ERROR! An unexpected system error occurred. Please restart the app and try again. If "
                "the issues persists, please contact a system administrator."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  static String getSecuredString(String str) {
    int strlength = str.length;
    int securedlength = 4;
    String ret = "";
    if (strlength < 0) {
      return null;
    }
    if (strlength < 5) {
      securedlength = (strlength/2).floor();
    }

    for(int i = 0; i < strlength; i++) {
      if((strlength - i) <= securedlength) {
        ret += str[i];
      } else {
        ret += "*";
      }
    }
    return ret;
  }

}