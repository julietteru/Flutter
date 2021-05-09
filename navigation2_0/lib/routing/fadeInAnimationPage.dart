import 'package:flutter/cupertino.dart';

class FadeInAnimationPage extends Page {
  final Widget child;

  FadeInAnimationPage({Key key, this.child}) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, animation2) {
          var curveTween = CurveTween(curve: Curves.easeIn);
          return FadeTransition(
            opacity: animation.drive(curveTween),
            child: this.child,
          );
        });
  }
}
