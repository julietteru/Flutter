import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import 'cognito.dart';

class AWSConfiguration {
  final AmplifyAuthCognito auth = new AmplifyAuthCognito();

  factory AWSConfiguration() {
    return _instance;
  }

  static final AWSConfiguration _instance = AWSConfiguration._internal();

  AWSConfiguration._internal() {
    _initializeAWS();
    Cognito.listenForAuthEvents();
  }

  _initializeAWS() async {
    try {
      await Amplify.addPlugin(auth);
      await Amplify.configure("");
    } catch (e) {
      print(e);
    }
  }
}
