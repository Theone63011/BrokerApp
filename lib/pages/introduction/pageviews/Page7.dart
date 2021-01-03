import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revire/pages/introduction/MyHomePage.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/pages/introduction/MyHomePage.dart';
import 'package:revire/LogLevels.dart';
import 'dart:developer' as developer;

class Page7 extends StatefulWidget {
  //Page7() : super();
  //final String title = MyHomePage.title;
  @override
  Page7State createState() => Page7State();
  //State<Page7> createState() => new Page7State(title, MyHomePage.sequenceNumber);
  //Page7State createState() => Page7State(title, MyHomePage.sequenceNumber);
}

enum UserTypes {
  BuyerSeller,
  BrokerAgent,
}


class Page7State extends State<Page7> with SingleTickerProviderStateMixin {

  AnimationController _animationController;

  static String className = "[Page7]";
  static String title;
  static int sequenceNumber = -1;
  static String logMsg = "EMPTY";

  //static int selectedRadioUserType; //0 - Buyer/Seller , 1 - Broker/Agent
  static int selectedRadioBuyerSeller;
  static int selectedRadioBrokerAgent;

  //static String selectedRadioUserType;


  //static Map<String, String> userTypes = {buyerSeller:buyerSeller, brokerAgent:brokerAgent};
  //static List<String> radioButtonOptions = [buyerSeller, brokerAgent];

  //UserTypes buyerSeller = UserTypes.BuyerSeller;
  //UserTypes brokerAgent = UserTypes.BrokerAgent;
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


  /*Page7State(String _title, int _sequenceNumber) {
    sequenceNumber = _sequenceNumber + 1;
    logMsg = "Constructor called";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
    title = _title;
  }*/

  /*@override
  void initState() {
    logMsg = "initState() called";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
    super.initState();
    logMsg = "initState() - selectedRadioBuyerSeller = [" + selectedRadioBuyerSeller.toString() +
        "], selectedRadioBrokerAgent = [" + selectedRadioBrokerAgent.toString() + "], selectedRadioUserType = [" +
        selectedRadioUserType + "]";

    if (selectedRadioUserType == buyerSeller) {
      selectedRadioBuyerSeller = 1;
      selectedRadioBrokerAgent = 0;
    } else if(selectedRadioUserType == brokerAgent) {
      selectedRadioBuyerSeller = 0;
      selectedRadioBrokerAgent = 1;
    } else if(selectedRadioUserType == "NOTSET") {
      selectedRadioBuyerSeller = 0;
      selectedRadioBrokerAgent = 0;
    } else {
      logMsg = "initState() - ERROR! \n\n'selectedRadioUserType' has unknown value = [" + selectedRadioUserType +
                "]. THIS SHOULD NOT HAPPEN!\n\n";
      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.error);
    }

    logMsg = "initState() finished. Actions completed:\n"
        "\tselectedRadioBuyerSeller (int) = [" + selectedRadioBuyerSeller.toString() + "]\n"
        "\tselectedRadioBrokerAgent (int) = [" + selectedRadioBrokerAgent.toString() + "]\n";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
  }*/

  /*List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (String usertype in radioButtonOptions) {
      widgets.add(
        RadioListTile(
          value: selectedRadioBuyerSeller,
          groupValue: 1,
          title: Text(usertype),
          onChanged: (currentUserType) {
            logMsg = "RadioListTile onChanged() called. input args: [currentUserType (String)] = [" + currentUserType
            + "]";
            developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
            selectedRadioBuyerSeller = 1;
          },
          selected: false,
          activeColor: selectedRadioColor,
        )
      );
    }
    return widgets;
  }*/

  /*Future<void> _selectRadioBuyerSeller() async {
    setState(() {
      selectedRadioBuyerSeller = 1;
      selectedRadioBrokerAgent = 0;
    });
    Directory directory = await getApplicationDocumentsDirectory();
    final String dirName = directory.path;
    await File('$dir/counter.txt').writeAsString('$_counter');
  }*/


/*class TextAndButtons extends StatelessWidget {

  static String className = "[TextAndButtons]";
  static String title;
  static int sequenceNumber = -1;
  static String logMsg = "EMPTY";
  static const String BUYERSELLERTEXT = "Buyer/Seller";
  static const String BROKERAGENTTEXT = "Broker/Agent";

  final AnimationController animationController;

  TextAndButtons({
    @required this.animationController,
  })

  @override
  Widget build(BuildContext context) {
    logMsg = "build(BuildContext context) called - context = [" + context.toString() + "]";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    *//*setState(() {
      logMsg = "setState() called.";
      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
      selectedRadioUserType = buyerSeller;
    });*//*


    *//*if(asyncSnapshot != null && asyncSnapshot.hasError) {
      logMsg = "ERROR: ${asyncSnapshot.error}";
      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
      return Text("ERROR: ${asyncSnapshot.error}");
    }*//*

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0,1),
        end: Offset.zero,
      ).animate(animationController),
      child: Scaffold (
        backgroundColor: MyAppColors.blue2,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Text(
                      'Before we continue, please tell us:\n\nAre you a',
                      style: MyAppTheme.data().textTheme.headline4,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                    RadioListTile<UserTypes>(
                      title: const Text(BUYERSELLERTEXT),
                      value: UserTypes.BuyerSeller,
                      groupValue: selectedUser,
                      onChanged: (UserTypes value) {
                        logMsg = "onChanged(UserTypes value) called - value = [" + value.toString() + "]";
                        developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

                        setState(() {
                          selectedUser = value;

                          logMsg = "setState() called. Actions completed:\n"
                              "\tselectedUser (UserTypes) = [" + value.toString() + "]\n";
                          developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
                        });
                      },
                    ),
                    RadioListTile<UserTypes>(
                      title: const Text(BROKERAGENTTEXT),
                      value: UserTypes.BrokerAgent,
                      groupValue: selectedUser,
                      onChanged: (UserTypes value) {
                        logMsg = "onChanged(UserTypes value) called - value = [" + value.toString() + "]";
                        developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

                        setState(() {
                          selectedUser = value;

                          logMsg = "setState() called. Actions completed:\n"
                              "\tselectedUser (UserTypes) = [" + value.toString() + "]\n";
                          developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
*/
  /*Widget data() {
    logMsg = "data() called.";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    return Scaffold(
      *//*appBar: AppBar(
        title: Text("[App Name]"),
      ),*//*
      backgroundColor: MyAppColors.blue2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Text(
                    'Before we continue, please tell us:\n\nAre you a',
                    style: MyAppTheme.data().textTheme.headline4,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  Column(
                      children: //createRadioListUsers(),
                      <Widget> [
                        RadioListTile(
                          value: selectedRadioBuyerSeller,
                          groupValue: 1,
                          title: Text(buyerSeller),
                          onChanged: (selectedRadioValue) {
                            logMsg = "RadioListTile onChanged() called. input args:\n"
                                "\tselectedRadioValue (int) = [" + selectedRadioValue.toString() + "]";
                            developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
                            //selectedRadioBuyerSeller = 1;
                            *//*setState(() {
                            selectedRadioBuyerSeller = 1;
                            });*//*
                            //selectedRadioUserType = buyerSeller;
                            //initState();
                            //setState(() {
                            //  selectedRadioUserType = buyerSeller;
                            //});
                            *//*setState(() {
                              selectedRadioBuyerSeller = 1;
                              selectedRadioBrokerAgent = 0;
                              selectedRadioUserType = buyerSeller;
                            });*//*
                          },
                          selected: false,
                          activeColor: selectedRadioColor,
                        ),
                        RadioListTile(
                          value: selectedRadioBrokerAgent,
                          groupValue: 1,
                          title: Text(brokerAgent),
                          onChanged: (selectedRadioValue) {
                            logMsg = "RadioListTile onChanged() called. input args:\n"
                                "\tselectedRadioValue (int) = [" + selectedRadioValue.toString() + "]";
                            developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
                            //selectedRadioBrokerAgent = 1;
                            *//*setState(() {
                            selectedRadioBrokerAgent = 1;
                            });*//*
                            //selectedRadioUserType = brokerAgent;
                            //initState();
                            *//*setState(() {
                              selectedRadioBuyerSeller = 0;
                              selectedRadioBrokerAgent = 1;
                              selectedRadioUserType = brokerAgent;
                            });*//*
                          },
                          selected: false,
                          activeColor: selectedRadioColor,
                        )
                      ]
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/