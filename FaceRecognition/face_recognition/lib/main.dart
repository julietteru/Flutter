import 'package:face_recognition/helpers/themeBuilder.dart';
import 'package:face_recognition/screens/startPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face recognition',
      theme: ThemeBuilder.build(context),
      home: Start(),
    );
  }
}


