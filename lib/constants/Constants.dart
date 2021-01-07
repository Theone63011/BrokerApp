import 'package:flutter/material.dart';
import 'package:revire/pages/login/MainLogin.dart';

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

}