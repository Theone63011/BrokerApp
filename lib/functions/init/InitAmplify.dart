import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:revire/amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/LogLevels.dart';
import 'package:revire/theme/MyAppColors.dart';
import 'package:revire/theme/MyAppTheme.dart';
import 'dart:developer' as developer;

class InitAmplify {

  static GlobalState _store = GlobalState.instance;
  static String className = "[InitAmplify]";
  static String classNameKey = "InitAmplify";
  static String title = Constants.NOTSET;
  static int sequenceNumber = -1;
  static String logMsg = Constants.EMPTY;
  static String amplifyInstanceKey = "[amplifyInstance]";
  static Amplify amplifyInstance;

  static Future<bool> init() async {
    logMsg = "init() has been called.\n" +
        Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    bool ret = false;

    _store.set(classNameKey, className);
    title = _store.get(Constants.titleKey);
    sequenceNumber = _store.get(Constants.sequenceNumberKey);
    sequenceNumber++;
    _store.set(Constants.sequenceNumberKey, sequenceNumber);

    amplifyInstance = Amplify();
    _store.set(amplifyInstanceKey, amplifyInstance);

    try {
      AmplifyAuthCognito authCognito = AmplifyAuthCognito();
      amplifyInstance.addPlugin(authPlugins: [authCognito]);
      await amplifyInstance.configure(amplifyconfig);


      logMsg = "amplifyInstance successfully configured.\n" +
          Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
      return true;
    } catch (error) {
      logMsg = "\n\tERROR in [init] - \n" + error.toString() +
          Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.error);
      return false;
    }

  }


}