import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/Logging.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/pages/login/MainLogin.dart';

class Page7 extends StatefulWidget {
  Page7({Key key}) : super(key: key);

  @override
  Page7State createState() => new Page7State();
}

class Page7State extends State<Page7> with SingleTickerProviderStateMixin {

  GlobalState _store = GlobalState.instance;
  static String className = (Page7State).toString();
  static Logging log = new Logging(className);
  static String line1 = "Before we start, please tell us\nAre you a";

  String selectedUser;
  bool userSelected;

  static double radioListIconSize = 25.0;
  static MaterialColor selectedRadioColor = MyAppColors.yellow1;

  @override
  void initState() {
    super.initState();
    log.info("initState() called.");
    userSelected = false;
    selectedUser = _store.get(Constants.selectedUserTypeKey);

    if (selectedUser != null) {
      if (selectedUser == Constants.buyerSellerType || selectedUser == Constants.brokerAgentType) {
        log.info("initState()- user has already been selected.");
        userSelected = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    log.info("build(BuildContext context) called.");

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
              title: Text(Constants.buyerSellerString),
              value: Constants.buyerSellerType,
              groupValue: selectedUser,
              activeColor: MyAppColors.yellow1,
              onChanged: (currentUser){
                log.info("onChanged(currentUser) called. currentUser - [" + currentUser.toString() + "]");
                setState(() {
                  selectedUser = currentUser;
                  userSelected = true;
                  _store.set(Constants.selectedUserTypeKey, Constants.buyerSellerType);
                });
              },
            ),
            RadioListTile(
              title: Text(Constants.brokerAgentString),
              value: Constants.brokerAgentType,
              groupValue: selectedUser,
              activeColor: MyAppColors.yellow1,
              onChanged: (currentUser){
                log.info("onChanged(currentUser) called. currentUser - [" + currentUser.toString() + "]");
                setState(() {
                  selectedUser = currentUser;
                  userSelected = true;
                  _store.set(Constants.selectedUserTypeKey, Constants.brokerAgentType);
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
                          log.info("onPressed() called.");
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