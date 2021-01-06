import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/main.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/pages/login/MainLogin.dart';
import 'dart:developer' as developer;

class Page7 extends StatefulWidget {
  Page7({Key key}) : super(key: key);

  @override
  Page7State createState() => new Page7State();
}

enum UserType {
  BuyerSeller,
  BrokerAgent,
}

class Page7State extends State<Page7> with SingleTickerProviderStateMixin {

  AnimationController _animationController;

  GlobalState _store = GlobalState.instance;
  static String className = "[Page7State]";
  static String classNameKey = "Page7State";
  static String title = Constants.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = Constants.EMPTY;
  static String line1 = "Before we start, please tell us\nAre you a";

  UserType selectedUser;
  bool userSelected;

  static double radioListIconSize = 25.0;
  static MaterialColor selectedRadioColor = MyAppColors.yellow1;

  @override
  void initState() {
    super.initState();
    userSelected = false;
    selectedUser = _store.get(Constants.selectedUserTypeKey);
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
      /*appBar: AppBar(
        title: Text("ReviRe TEST AppBar"),
        centerTitle: true,
      ),*/
      backgroundColor: MyAppColors.blue2,
      body: new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              line1,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .headline3,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            RadioListTile(
              title: Text("Buyer/Seller"),
              value: UserType.BuyerSeller,
              groupValue: selectedUser,
              activeColor: MyAppColors.yellow1,
              onChanged: (currentUser){
                logMsg = "onChanged(currentUser) called.\n"
                    "currentUser - [" + currentUser.toString() + "]" +
                    Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
                developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

                setState(() {
                  selectedUser = currentUser;
                  userSelected = true;
                  _store.set(Constants.selectedUserTypeKey, selectedUser);
                });
              },
            ),
            RadioListTile(
              title: Text("Broker/Agent"),
              value: UserType.BrokerAgent,
              groupValue: selectedUser,
              activeColor: MyAppColors.yellow1,
              onChanged: (currentUser){
                logMsg = "onChanged(currentUser) called.\n"
                    "currentUser - [" + currentUser.toString() + "]" +
                    Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
                developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

                setState(() {
                  selectedUser = currentUser;
                  userSelected = true;
                  _store.set(Constants.selectedUserTypeKey, selectedUser);
                });
              },
            ),
            Visibility(
              visible: userSelected,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: AnimatedOpacity(
                  opacity: userSelected == true ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                        child: Icon(Icons.arrow_forward_ios),
                        backgroundColor: MyAppColors.green1,
                        onPressed: () {
                          logMsg = "onPressed() called.\n" +
                              Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
                          developer.log(
                              className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainLogin()),
                          );
                        },
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}