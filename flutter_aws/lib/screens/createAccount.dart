import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws/helpers/routeBuilder.dart';
import 'package:flutter_aws/helpers/themeBuilder.dart';
import 'package:flutter_aws/models/user.dart';
import 'package:flutter_aws/screens/verificationCode.dart';
import 'package:flutter_aws/services/cognito.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool successfulSignUp = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final auth = Cognito();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            SizedBox(
              height: 90,
            ),
            Center(
                child: Text(
              'Create Account',
              style: Theme.of(context).textTheme.headline2,
            )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return "Must enter an username";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return "Must enter an email";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return "Must enter a password";
                }
                return null;
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: "Confirm Password",
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return "Must enter a password";
                }
                var password = passwordController.text;
                if (value != password) {
                  return "Passwords must match";
                }
                return null;
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  var isValid = _formKey.currentState.validate();
                  if (isValid != null && isValid) {
                    var user = new User(usernameController.text,
                        emailController.text, passwordController.text);
                    var success = await _showLoadingDialog(context, user);
                    if (success) {
                      Navigator.of(context).push(createRoute(
                          VerificationCodeScreen(
                              username: user.userName, auth: auth)));
                    }
                  }
                },
                child: Text("Create"))
          ],
        ),
      ),
    );
  }

  Future<bool> _showLoadingDialog(BuildContext context, User user) async {
    var textTheme = Theme.of(context).textTheme;
    var success = false;
    await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              backgroundColor: ThemeColors.accent,
              contentPadding: EdgeInsets.symmetric(vertical: 25.0),
              title: Center(
                child: Text(
                  "Creating Account",
                  style: textTheme.headline6,
                ),
              ),
              children: [
                FutureBuilder<bool>(
                  future: auth.signUp(user),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        "An error has occured",
                        style: textTheme.bodyText1,
                      );
                    }
                    if (snapshot.hasData) {
                      success = snapshot.data;
                      Navigator.of(context).pop();
                      return SizedBox();
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: ThemeColors.primaryVariant,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(ThemeColors.accent),
                      ),
                    );
                  },
                )
              ],
            ));
    return success;
  }
}
