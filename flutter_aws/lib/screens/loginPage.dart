import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws/helpers/custom_icons_icons.dart';
import 'package:flutter_aws/helpers/routeBuilder.dart';
import 'package:flutter_aws/screens/createAccount.dart';
import 'package:flutter_aws/screens/home.dart';
import 'package:flutter_aws/services/cognito.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final Cognito _auth = Cognito();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                controller: userNameController,
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
              ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
                    var isValid = _formKey.currentState.validate();
                    if (isValid != null && isValid) {
                      var username = userNameController.text;
                      var password = passwordController.text;
                      var wasSuccessful = await _auth.signIn(username, password);
                      if (wasSuccessful) {
                        await _auth.fetchUserAttributes();
                        Navigator.of(context).push(createRoute(Home()));
                      }
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
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
