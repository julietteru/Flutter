import 'package:flutter/material.dart';
import 'package:navigation2_0/bookAppState.dart';
import 'package:navigation2_0/screens/option1Screen.dart';

class SideNav extends StatelessWidget {
  final BookAppState _appState;

  SideNav(this._appState);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(child: Center(child: Text("Header"))),
        ListTile(
          title: Text("Option 1"),
          onTap: () {
            _appState.drawerOption = Option1();
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
