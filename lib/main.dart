// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/pages/introduction/MyHomePage.dart';
import 'package:revire/pages/introduction/pageviews/Page1.dart';
import 'package:revire/pages/introduction/pageviews/Page2.dart';
import 'package:revire/pages/introduction/pageviews/Page3.dart';
import 'package:revire/pages/introduction/pageviews/Page4.dart';
import 'package:revire/pages/introduction/pageviews/Page5.dart';
import 'package:revire/pages/introduction/pageviews/Page6.dart';
import 'package:revire/pages/introduction/pageviews/Page7.dart';

import 'package:flutter_login/flutter_login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//void main() => runApp(MyApp());
void main() => runApp(new MaterialApp(home: new MyApp(),));

class MyApp extends StatelessWidget {

  static final theme = MyAppTheme.data();
  static int sequenceNumber = 0;
  GlobalState _store = GlobalState.instance;

  @override
  Widget build(BuildContext context) {

    _store.set(Constants.titleKey, Constants.title);
    _store.set(Constants.sequenceNumberKey, sequenceNumber);

    return MaterialApp(
      title: Constants.title,
      theme: theme,
      //routes: <String, WidgetBuilder>{
      //  Page1State.classNameKey: (BuildContext context) => new Page1(),
      //},
      home: new Page1(),
    );
  }
}