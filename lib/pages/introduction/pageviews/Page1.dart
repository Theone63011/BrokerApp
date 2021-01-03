import 'package:flutter/material.dart';
import 'package:revire/main.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/pages/introduction/pageviews/Page2.dart';
import 'dart:developer' as developer;

class Page1 extends StatefulWidget {
  Page1({Key key}) : super(key: key);

  @override
  Page1State createState() => new Page1State();
}


class Page1State extends State<Page1> {

  GlobalState _store = GlobalState.instance;

  //PageController _pageController;

  /*TODO: Used for text input box
  final textController = TextEditingController();
  */

  static String className = "[Page1State]";
  static String classNameKey = "Page1State";
  static String title = MyApp.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = MyApp.EMPTY;

  static String line1 = "Welcome To";
  static String line2 = title;

  // TODO: Sample logging message
  /*
  logMsg = "[Placeholder]";
  developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
  */

  @override
  void initState() {
    super.initState();
    _store.set(classNameKey, className);
    title = _store.get(MyApp.titleKey);
    sequenceNumber = _store.get(MyApp.sequenceNumberKey);
    sequenceNumber++;
    _store.set(MyApp.sequenceNumberKey, sequenceNumber);

    //_pageController = PageController();

    // TODO: Used for text input box
    /*textController.addListener(() {
      final text = textController.text.toLowerCase();
      textController.value = textController.value.copyWith(
        text: text,
        selection:
          TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });*/
  }


  /*@override
  void dispose() {
    // TODO: Used for text input box
    //textController.dispose();

    _pageController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    logMsg = "build(BuildContext context) called.\n" +
        MyApp.sequenceNumberKey + ": " + sequenceNumber.toString();
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    return Scaffold(
      backgroundColor: MyAppColors.blue2,
      body: new Container(
        //padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              line1,
              style: MyAppTheme.data().textTheme.headline2,
            ),
            Text(
              line2,
              style: MyAppTheme.data().textTheme.headline2,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: MyAppColors.green1,
        onPressed: (){
          logMsg = "onPressed() called.\n" +
              MyApp.sequenceNumberKey + ": " + sequenceNumber.toString();
          developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page2()),
          );
        },
      ),
    );
  }
}