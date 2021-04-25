import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class LogoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoAppState();
}

class LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
    late AnimationController controller;
    late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();
      } else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation Demo")),
      body: Center(
        child: AnimatedLogo(animation: animation),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {

  static final sizeAnimation = Tween<double>(begin: 0, end: 300);
  static final opacityAnimation = Tween<double>(begin: 0.1, end: 1.0);

  AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Opacity(
      opacity: opacityAnimation.evaluate(animation),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: sizeAnimation.evaluate(animation),
        width: sizeAnimation.evaluate(animation),
        child: FlutterLogo(),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const GrowTransition({Key? key, required this.animation, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Container(
                height: animation.value,
                width: animation.value,
                child: child,
              );
            },
            child: child));
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FlutterLogo(),
    );
  }
}
