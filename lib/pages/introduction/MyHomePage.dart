import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  GlobalState _store = GlobalState.instance;
  static String className = (MyHomePageState).toString();
  static Logging log = new Logging(className);

  @override
  void initState() {
    super.initState();
    log.info("initState() called.");
  }

  Widget title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: Constants.title,
        style: GoogleFonts.portLligatSans(
          textStyle: MyAppTheme.data().textTheme.headline1,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: MyAppColors.blue1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log.info("build(BuildContext context) called.");

    Constants.showInProgressDialog(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.title),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {
              Navigator.of(context).pop(),
            },
          )
        ],
      ),
      backgroundColor: MyAppColors.blue2,
      body: new Container(
        //padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Constants.title,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .headline1,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}