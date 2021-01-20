import 'package:flutter/material.dart';
import 'package:revire/pages/login/MainLogin.dart';
import 'package:revire/constants/GlobalState.dart';

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
  static final String amplifyInstanceKey = "amplifyInstance";
  static final String signUpCompleteKey = "signUpComplete";
  static final String loginCompleteKey = "loginComplete";
  static final String loginDataKey = "loginData";

  static GlobalState _store = GlobalState.instance;

  static int incrementSequenceNumber() {
    int sequenceNumber = _store.get(sequenceNumberKey);
    sequenceNumber++;
    _store.set(sequenceNumberKey, sequenceNumber);
    return sequenceNumber;
  }

  static void showInProgressDialog(BuildContext context) {
    showDialog(
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

  static void showDialog_CloseOption(BuildContext context, String title, String body) {
    showDialog(
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

}