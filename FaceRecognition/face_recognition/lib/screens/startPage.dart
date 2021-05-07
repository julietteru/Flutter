import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Face recognition App'),
          ElevatedButton(onPressed: (){}, child: Text('START'))
        ],
      ),
    );
  }
}