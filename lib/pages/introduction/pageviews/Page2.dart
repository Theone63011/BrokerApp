import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/pages/introduction/pageviews/Page3.dart';

class Page2 extends StatefulWidget {
  Page2({Key key}) : super(key: key);

  @override
  Page2State createState() => new Page2State();
}

class Page2State extends State<Page2> {

  static String className = (Page2State).toString();
  static Logging log = new Logging(className);

  static String line1 = Constants.title + " is your \nall-in-one real estate experience,\nfrom the palm of your hand.";

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
            MaterialPageRoute(builder: (context) => Page3()),
          );
        },
      ),
    );
  }
}
