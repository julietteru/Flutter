import 'package:flutter/widgets.dart';

Route createRoute(Widget child) {
  return PageRouteBuilder(
      pageBuilder: (settings, animation1, animation2) => child,
      transitionsBuilder: (context, animation, secondAnimation, child) {
        var curveTween = CurveTween(curve: Curves.easeIn);
        return FadeTransition(
          opacity: animation.drive(curveTween),
          child: child,
        );
      });
}
