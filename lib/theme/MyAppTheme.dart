import 'package:flutter/material.dart';
import 'package:revire/theme/MyAppColors.dart';

@immutable
class MyAppTheme {
  static const COLORS = MyAppColors();

  MyAppTheme();

  static final List<Shadow> shadows = <Shadow>[
    Shadow(
        offset: Offset(0.0, 0.0),
        blurRadius: 10.0,
        color: Colors.black12
    ),
  ];

  static ThemeData data() {
    return ThemeData(
      fontFamily: "SFRegular",
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white, fontSize: 42.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto', shadows: shadows),
        headline2: TextStyle(color: Colors.white, fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto', shadows: shadows),
        headline3: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto', shadows: shadows),
        headline4: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto', shadows: shadows),
        headline5: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto', shadows: shadows),
        bodyText1: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto',
            shadows: shadows),
        bodyText2: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto',
            shadows: shadows),
      ),
      primarySwatch: MyAppColors.blue1,
      //visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData titleTheme() {
    return ThemeData(
      fontFamily: "SFRegular",
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto',
            shadows: shadows),
      ),
      primarySwatch: MyAppColors.blue1
    );
  }
}
