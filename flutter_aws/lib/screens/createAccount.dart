import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
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
              labelText: "Email",
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return "Must enter an email";
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
          TextFormField(
            decoration: InputDecoration(
              labelText: "Confirm Password",
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
              child: Text("Login"))
        ],
      ),
    );
  }
}
