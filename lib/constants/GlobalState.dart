import 'package:flutter/material.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/LogLevels.dart';
import 'dart:developer' as developer;

class GlobalState {
  static final Map<dynamic, dynamic> _data = <dynamic, dynamic>{};

  static GlobalState instance = new GlobalState._();

  static String className = "[GlobalState]";
  static String classNameKey = "GlobalState";
  static int sequenceNumber = -1;
  static String logMsg = Constants.EMPTY;

  GlobalState._();

  set(dynamic key, dynamic value) => _data[key] = value;
  get(dynamic key) => _data[key];

  static void printCurrentState() async{
    sequenceNumber = instance.get(Constants.sequenceNumberKey);
    sequenceNumber++;
    instance.set(Constants.sequenceNumberKey, sequenceNumber);

    logMsg = "printCurrentState() called.\n\n\tPrinting current GlobalState.\n" +
        Constants.sequenceNumberKey + ": " + sequenceNumber.toString();
    developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);

    int i = 1;

    _data.forEach((key, value) {
      logMsg = "\n\t" + i.toString() + ") key = [" + key.toString() + "], value = [" + value.toString() + "]";
      developer.log(className + logMsg, time: DateTime.now(), sequenceNumber: sequenceNumber, level: LogLevels.info);
      i++;
    });
  }
}