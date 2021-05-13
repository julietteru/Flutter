import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws/amplifyconfiguration.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter_aws/screens/loginPage.dart';
import 'package:flutter_aws/helpers/themeBuilder.dart';

void main() {
  runApp(AWSDemo());
}

class AWSDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AWSDemoState();
}

class AWSDemoState extends State<AWSDemo> {
  final AmplifyAPI _amplifyApi = new AmplifyAPI();
  final AmplifyAuthCognito _cognito = new AmplifyAuthCognito();

  _initializeAWS() async {
    try {
      await Amplify.addPlugins([_amplifyApi, _cognito]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _initializeAWS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AWS-Flutter Integration",
      theme: ThemeBuilder.build(context),
      home: LoginScreen(),
    );
  }
}
