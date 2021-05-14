import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws/helpers/routeBuilder.dart';
import 'package:flutter_aws/helpers/themeBuilder.dart';
import 'package:flutter_aws/screens/loginPage.dart';
import 'package:flutter_aws/services/cognito.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String username;
  final Cognito auth;

  const VerificationCodeScreen({Key key, this.username, this.auth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Please enter the verification code sent to your email address",
              style: textTheme.headline3,
            )),
            SizedBox(
              height: 25,
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Verification Code",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ThemeColors.accent,
                            style: BorderStyle.solid,
                            width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ThemeColors.accent,
                            style: BorderStyle.solid,
                            width: 2)),
                    fillColor: Colors.transparent),
                keyboardType: TextInputType.number,
                onSubmitted: (value) async {
                  var success = await auth.confirmSignUp(username, value);
                  if (success) {
                    Navigator.push(context, createRoute(LoginScreen()));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
