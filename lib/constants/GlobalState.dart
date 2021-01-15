import 'package:flutter/material.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/Logging.dart';
import 'dart:developer' as developer;

class GlobalState {
  static final Map<dynamic, dynamic> _data = <dynamic, dynamic>{};

  static GlobalState instance = new GlobalState._();

  static String className = (GlobalState).toString();
  static Logging log = new Logging(className);
  static int sequenceNumber = -1;

  GlobalState._();

  set(dynamic key, dynamic value) => _data[key] = value;
  get(dynamic key) => _data[key];

  static void printCurrentState() async {
    log.info("printCurrentState() called.\n\n\tPrinting current GlobalState...\n");

    int i = 1;

    _data.forEach((key, value) {
      log.info(i.toString() + ") key = [" + key.toString() + "], value = [" + value.toString() + "]");
      i++;
    });
  }
}