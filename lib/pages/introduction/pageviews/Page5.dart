import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/pages/introduction/pageviews/Page6.dart';

class Page5 extends StatefulWidget {
  Page5({Key key}) : super(key: key);

  @override
  Page5State createState() => new Page5State();
}

class Page5State extends State<Page5> {
  static String className = (Page5State).toString();
  static Logging log = new Logging(className);

  static String line1 = "To make sure your buying or selling experience is safe and secure, we have implemented\n";
  static String line2 = "- Multi-factor authentication\n- Active threat detection & prevention\n- Crypto agility\n";
  static String line3 = "and many more top level security protocols.";

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
                  .headline4,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            Text(
              line2,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .headline5,
              textAlign: TextAlign.left,
              softWrap: true,
            ),
            Text(
              line3,
              style: MyAppTheme
                  .data()
                  .textTheme
                  .headline4,
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
            MaterialPageRoute(builder: (context) => Page6()),
          );
        },
      ),
    );
  }
}
