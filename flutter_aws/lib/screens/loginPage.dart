import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws/helpers/custom_icons_icons.dart';
import 'package:flutter_aws/helpers/routeBuilder.dart';
import 'package:flutter_aws/helpers/themeBuilder.dart';
import 'package:flutter_aws/screens/createAccount.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            SizedBox(
              height: 150,
            ),
            Icon(
              CustomIcons.aws,
              size: 70,
            ),
            SizedBox(
              height: 80,
            ),
            Center(
                child: Text(
              'Login',
              style: Theme.of(context).textTheme.headline2,
            )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Username",
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return "Must enter an username";
                }
                return "";
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return "Must enter a password";
                }
                return "";
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  var isValid = _formKey.currentState.validate();
                  if (isValid != null && isValid) {
                    //To do: call cognito and login
                  }
                },
                child: Text("Login")),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.headline4,
                    children: [
                  TextSpan(text: "Don\'t have an account? "),
                  TextSpan(
                      text: "create one!",
                      style: Theme.of(context).textTheme.headline5,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .push(createRoute(CreateAccountScreen()));
                        })
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
