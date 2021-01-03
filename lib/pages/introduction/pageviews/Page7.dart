import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/main.dart';
import 'package:revire/constants/GlobalState.dart';
import 'dart:developer' as developer;

class Page7 extends StatefulWidget {
  Page7({Key key}) : super(key: key);

  @override
  Page7State createState() => new Page7State();
}

enum UserTypes {
  BuyerSeller,
  BrokerAgent,
}

class Page7State extends State<Page7> with SingleTickerProviderStateMixin {

  AnimationController _animationController;

  GlobalState _store = GlobalState.instance;
  static String className = "[Page7State]";
  static String classNameKey = "Page7State";
  static String title = MyApp.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = MyApp.EMPTY;

  int selectedRadio;
  int selectedRadioTile;

  UserTypes selectedUser = UserTypes.BuyerSeller;

  static double radioListIconSize = 25.0;
  static MaterialColor selectedRadioColor = MyAppColors.yellow1;

  bool loading = true;
  AsyncSnapshot asyncSnapshot;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 150)
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ReviRe TEST AppBar"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          //TextAndButtons(animationController: _animationController,),
        ],
      ),
    );
  }
}