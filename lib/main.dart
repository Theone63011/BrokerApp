// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/pages/introduction/pageviews/Page1.dart';
import 'package:revire/functions/init/Init.dart';
import 'package:revire/Logging.dart';

void main() => runApp(new MaterialApp(home: new MyApp(),));

class MyApp extends StatelessWidget {

  static final theme = MyAppTheme.data();
  static int sequenceNumber = 0;
  static GlobalState _store = GlobalState.instance;
  static String className = (MyApp).toString();
  static Logging log = new Logging(className);

  @override
  Widget build(BuildContext context) {

    _store.set(Constants.titleKey, Constants.title);
    _store.set(Constants.sequenceNumberKey, sequenceNumber);

    initApp();

    return MaterialApp(
      title: Constants.title,
      theme: theme,
      //routes: <String, WidgetBuilder>{
      //  Page1State.classNameKey: (BuildContext context) => new Page1(),
      //},
      home: new Page1(),
    );
  }

  static void initApp() {
    log.info("initApp() starting...");

    Timeline.startSync("initApp() started");
    int start = Timeline.now;
    Init.init();
    Timeline.finishSync();
    int end = Timeline.now;
    double runtime = (end - start) / 1000;

    log.info("initApp() completed in [" + runtime.toStringAsFixed(2) + "] seconds");
  }
}