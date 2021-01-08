import 'package:amplify_core/amplify_core.dart';
import 'package:revire/amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'package:revire/functions/init/InitAmplify.dart';
import 'dart:developer' as developer;

class Init {

  static GlobalState _store = GlobalState.instance;
  static String className = "[Init]";
  static String classNameKey = "Init";
  static String title = Constants.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = Constants.EMPTY;

  static Future<bool> init() async {
    logMsg = "init() has been called.\n" +
        Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    _store.set(classNameKey, className);
    title = _store.get(Constants.titleKey);
    sequenceNumber = _store.get(Constants.sequenceNumberKey);
    sequenceNumber++;
    _store.set(Constants.sequenceNumberKey, sequenceNumber);

    bool initAmplifyResult = await initAmplify();
    if (initAmplifyResult == false) {
      return initAmplifyResult;
    }

    return true;
  }

  static Future<bool> initAmplify() async {
    logMsg = "initAmplify() has been called.\n" +
        Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    try {
      bool result = await InitAmplify.init();
      return true;
    } catch (error) {
      logMsg = "\n\tERROR in [initAmplify] - \n" + error.toString() +
          Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.error);
      return false;
    }
  }
}