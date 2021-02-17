import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:revire/amplifyconfiguration.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/Logging.dart';

class InitAmplify {

  static GlobalState _store = GlobalState.instance;
  static String className = (InitAmplify).toString();
  static Logging log = new Logging(className);
  static String amplifyInstanceKey = "[amplifyInstance]";
  //static Amplify amplifyInstance;

  static Future<bool> init() async {
    log.info("init() has been called.");

    bool ret = false;

    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    Amplify.addPlugins([authPlugin, analyticsPlugin]);

    try {
      await Amplify.configure(amplifyconfig);
      log.info("Amplify successfully configured.");
      return true;
    } catch (error) {
      log.error("exception caught in [init()] - \n" + error.toString() + "\n" );
      return false;
    }

  }


}