import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/pages/introduction/pageviews/Page2.dart';

class Page1 extends StatefulWidget {
  Page1({Key key}) : super(key: key);

  @override
  Page1State createState() => new Page1State();
}

class Page1State extends State<Page1> {
  static String className = (Page1State).toString();
  static Logging log = new Logging(className);

  static String line1 = "Welcome To";
  static String line2 = Constants.title;

  @override
  void initState() {
    super.initState();
    log.info("initState() called.");
  }

  @override
  Widget build(BuildContext context) {
    log.info("build(BuildContext context) called.");

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
          log.info("onPressed() called.");
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page2()),
          );

          // TODO: How to go back to previous navigator transition
          //Navigator.pop(context);
        },
      ),
    );
  }
}