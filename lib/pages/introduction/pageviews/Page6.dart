import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/pages/introduction/pageviews/Page7.dart';

class Page6 extends StatefulWidget {
  Page6({Key key}) : super(key: key);

  @override
  Page6State createState() => new Page6State();
}

class Page6State extends State<Page6> {
  static String className = (Page6State).toString();
  static Logging log = new Logging(className);

  static String line1 = "We hope that your experience with " + Constants.title + " is as valuable as the memories made "
      "in your "
      "home.";
  static String line2 = "\n\n\n\n\n\n- sincerely";
  static String line3 = "The " + Constants.title + " Team";

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
              style: MyAppTheme
                  .data()
                  .textTheme
                  .headline3,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            Text(
              line2,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .bodyText1,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            Text(
              line3,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .bodyText1,
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: MyAppColors.green1,
        onPressed: () {
          log.info("onPressed() called.");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page7()),
          );
        },
      ),
    );
  }
}
