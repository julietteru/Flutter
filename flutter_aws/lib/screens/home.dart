import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AWS Demo"),
      ),
      drawer: Drawer(), //Todo: build drawer
      body: Center(
        child: Text("User logged in!"),
      ),
      bottomNavigationBar: BottomAppBar(), //todo build options
    );
  }
}
