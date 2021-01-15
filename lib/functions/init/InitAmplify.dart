import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:revire/amplifyconfiguration.dart';
import 'package:revire/constants/Constants.dart';
import 'package:revire/constants/GlobalState.dart';
import 'package:revire/Logging.dart';

class InitAmplify {

  static GlobalState _store = GlobalState.instance;
  static String className = (InitAmplify).toString();
  static Logging log = new Logging(className);
  static String amplifyInstanceKey = "[amplifyInstance]";
  static Amplify amplifyInstance;

  static Future<bool> init() async {
    log.info("init() has been called.");

    bool ret = false;

    amplifyInstance = Amplify();
    _store.set(amplifyInstanceKey, amplifyInstance);

    try {
      AmplifyAuthCognito authCognito = AmplifyAuthCognito();
      amplifyInstance.addPlugin(authPlugins: [authCognito]);
      await amplifyInstance.configure(amplifyconfig);

      _store.set(Constants.amplifyInstanceKey, amplifyInstance);

      log.info("amplifyInstance successfully configured.");
      return true;
    } catch (error) {
      log.error("exception caught in [init()] - \n" + error.toString() + "\n" );
      return false;
    }

  }


}