import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:revire/main.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/pages/introduction/pageviews/Page1.dart';
import 'package:revire/pages/introduction/pageviews/Page2.dart';
import 'package:revire/pages/introduction/pageviews/Page3.dart';
import 'package:revire/pages/introduction/pageviews/Page4.dart';
import 'package:revire/pages/introduction/pageviews/Page5.dart';
import 'package:revire/pages/introduction/pageviews/Page6.dart';
import 'package:revire/pages/introduction/pageviews/Page7.dart';
import 'package:revire/LogLevels.dart';
import 'dart:developer' as developer;

/*
class MyHomePage extends StatelessWidget {

//}

//class _MyHomePageState extends State<MyHomePage> {

  final List<Widget> introWidgetList = <Widget>[
    //Page1.data(),
    Page2.data(),
    Page3.data(),
    Page4.data(),
    Page5.data(),
    Page6.data(),
  ];

  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {

    return Container(
      color: MyAppColors.blue2,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PageView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: introWidgetList.length,
              onPageChanged: (int pagenumber) {
                getChangedPageAndMoveIndicator(pagenumber);
              },
              controller: _pageController,
              itemBuilder: (context, index) {
                return introWidgetList[index];
              }),
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 35),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < introWidgetList.length; i++)
                      if (i == currentPageValue) ...[circleBar(true)] else circleBar(false),
                  ],
                ),
              )
            ],
          ),
          Visibility(
              visible: currentPageValue == introWidgetList.length - 1 ? true : false,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: AnimatedOpacity(
                  opacity: currentPageValue == introWidgetList.length - 1 ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    child: FloatingActionButton(
                      elevation: 40,
                      onPressed: () {
                        logMsg = "onPressed() called.";
                        developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

                        //Navigator.of(context).push(openPage7());

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return Page7();
                            }
                          )
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );


  }

  Widget circleBar(bool isActive) {
    logMsg = "circleBar(bool isActive) called - isActive = [" + isActive.toString() + "]";
    //developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    return Visibility(
      visible: currentPageValue == introWidgetList.length - 1 ? false : true,
      child: AnimatedOpacity(
        opacity: currentPageValue == introWidgetList.length - 1 ? 0.0 : 1.0,
        duration: Duration(milliseconds: 500),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(horizontal: 8),
          height: isActive ? 12 : 8,
          width: isActive ? 12 : 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : MyAppColors.blue3,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
    /*return
    );*/
  }

  void getChangedPageAndMoveIndicator(int page) {
    logMsg = "getChangedPageAndMoveIndicator(int page) called.";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    currentPageValue = page;
    setState(() {});
  }

  static Route openPage7() {
    logMsg = "openPage7() called.";
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);


    //TODO- continue fixing broken radio button troubleshooting below
    //Page7State page7state = new Page7State(MyApp.title, sequenceNumber);


    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page7State(MyApp.title, sequenceNumber).build
        (context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        //var curveTween = CurveTween(curve: curve);
        var tween = Tween(begin: begin, end: end);//.chain(curveTween);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        /*return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );*/

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}*/
