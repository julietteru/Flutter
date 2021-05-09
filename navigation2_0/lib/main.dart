import 'package:flutter/material.dart';
import 'package:navigation2_0/routing/bookRouterDelegate.dart';
import 'package:navigation2_0/routing/routeInformationParser.dart';

void main() {
  runApp(NestedRouterDemo());
}

class NestedRouterDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NestedRouterDemoState();
}

class _NestedRouterDemoState extends State<NestedRouterDemo> {
  BookRouterDelegate _bookRouterDelegate = BookRouterDelegate();
  BookRouteInformationParser _bookRouteInformationParser = BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: "Books App",
        routeInformationParser: _bookRouteInformationParser,
        routerDelegate: _bookRouterDelegate);
  }
}