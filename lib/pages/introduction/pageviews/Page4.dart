import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/pages/introduction/pageviews/Page5.dart';

class Page4 extends StatefulWidget {
  Page4({Key key}) : super(key: key);

  @override
  Page4State createState() => new Page4State();
}

class Page4State extends State<Page4> {
  static String className = (Page4State).toString();
  static Logging log = new Logging(className);

  static String line1 = "At " + Constants.title + ", we take your privacy and security seriously.";

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
            MaterialPageRoute(builder: (context) => Page5()),
          );
        },
      ),
    );
  }
}
