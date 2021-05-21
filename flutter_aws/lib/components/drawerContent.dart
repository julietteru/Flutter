import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws/helpers/custom_icons_icons.dart';
import 'package:flutter_aws/helpers/routeBuilder.dart';
import 'package:flutter_aws/helpers/themeBuilder.dart';
import 'package:flutter_aws/screens/loginPage.dart';
import 'package:flutter_aws/services/cognito.dart';

class DrawerContent extends StatelessWidget {
  final Cognito _auth = Cognito();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Flexible(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: ThemeColors.accent,
                ),
                child: Icon(
                  CustomIcons.aws,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: Text(
                  "Change Password",
                  style: textTheme.headline3,
                ),
              ),
              ListTile(
                title: Text(
                  "Option 2",
                  style: textTheme.headline3,
                ),
              ),
              ListTile(
                title: Text(
                  "Option 3",
                  style: textTheme.headline3,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: ListTile(
            title: Text(
              'Sign out',
              style: textTheme.headline3.copyWith(fontStyle: FontStyle.italic),
            ),
            onTap: () async {
              await _auth.signOut();
              Navigator.of(context).push(createRoute(LoginScreen()));
            },
          ),
        ),
      ],
    );
  }
}
