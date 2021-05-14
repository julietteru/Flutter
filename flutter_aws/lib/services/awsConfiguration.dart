import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import '../amplifyconfiguration.dart';

class AWSConfiguration {
  final AmplifyAuthCognito auth = new AmplifyAuthCognito();
  final AmplifyAPI amplifyApi = new AmplifyAPI();

  factory AWSConfiguration() {
    return _instance;
  }

  static final AWSConfiguration _instance = AWSConfiguration._internal();

  AWSConfiguration._internal() {
    _initializeAWS();
  }

  _initializeAWS() async {
    try {
      await Amplify.addPlugins([amplifyApi, auth]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print(e);
    }
  }
}
