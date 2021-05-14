import 'package:flutter/material.dart';
import 'package:flutter_aws/screens/loginPage.dart';
import 'package:flutter_aws/helpers/themeBuilder.dart';
import 'package:flutter_aws/services/awsConfiguration.dart';

void main() {
  runApp(AWSDemo());
}

class AWSDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AWSDemoState();
}

class AWSDemoState extends State<AWSDemo> {


  @override
  void initState() {
    AWSConfiguration();
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
