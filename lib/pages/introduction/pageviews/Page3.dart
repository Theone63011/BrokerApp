import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/pages/introduction/pageviews/Page4.dart';

class Page3 extends StatefulWidget {
  Page3({Key key}) : super(key: key);

  @override
  Page3State createState() => new Page3State();
}

class Page3State extends State<Page3> {
  static String className = (Page3State).toString();
  static Logging log = new Logging(className);

  static String line1 = "With " + Constants.title + ", you will never again have to worry about buying or selling your "
      "home.\n"
      "We have your needs covered.";

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
            MaterialPageRoute(builder: (context) => Page4()),
          );
        },
      ),
    );
  }
}
