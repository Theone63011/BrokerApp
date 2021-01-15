import 'package:flutter/material.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'dart:developer' as developer;

class Logging {

  final int DEBUG = DiagnosticLevel.debug.index;
  final int ERROR = DiagnosticLevel.error.index;
  final int FINE = DiagnosticLevel.fine.index;
  final int INFO = DiagnosticLevel.info.index;
  final int WARNING = DiagnosticLevel.warning.index;
  final int SUMMARY = DiagnosticLevel.summary.index;

  String className = Constants.NOTSET;

  Logging(String _classname) {
    className = _classname;
  }

  void log (String msg, int logLevel) {
    int sequenceNumber = Constants.incrementSequenceNumber();
    developer.log(
      "[" + className + "]" +
          "[Timestamp: " + DateTime.now().toString() + "]" +
          "[sequenceNumber: " + sequenceNumber.toString() + "]\n\t" + msg,
      time: DateTime.now(),
      sequenceNumber: sequenceNumber,
      level: logLevel,
    );
  }

  void info (String msg) {
    log(msg, INFO);
  }

  void debug (String msg) {
    log(msg, DEBUG);
  }

  void warn (String msg) {
    log("\t\t\t WARNING- " + msg, WARNING);
  }

  void error (String msg) {
    log("\t\t\t ERROR- " + msg, ERROR);
  }

  void fine (String msg) {
    log(msg, FINE);
  }

  void summary (String msg) {
    log(msg, SUMMARY);
  }
}