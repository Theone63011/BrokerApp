import 'package:revire/constants/Constants.dart';
import 'package:revire/Logging.dart';
import 'package:revire/functions/init/InitAmplify.dart';
import 'dart:developer' as developer;

class Init {
  static String className = (Init).toString();
  static Logging log = new Logging(className);

  static void init() async {
    log.info("init() has been called.");

    bool initAmplifyResult = await initAmplify();
    if (initAmplifyResult) {
      log.info("initAmplify() completed successfully.");
    } else {
      log.error("initAmplify() FAILED!");
    }

    log.info("Init complete.");
  }

  static Future<bool> initAmplify() async {
    log.info("initAmplify() has been called.");

    try {
      bool result = await InitAmplify.init();
      return true;
    } catch (error) {
      log.error("exception caught in [initAmplify()] - \n" + error.toString() + "\n");
    }
  }
}