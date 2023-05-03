import 'package:flutter/material.dart';

enum Transitions {
  fade,
  rotation,
  scale,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
}

abstract class CustomTransitionRoute {
  static Widget selectTransition(
    Widget child,
    Animation<double> animation,
    Transitions transitions,
  ) {
    switch (transitions) {
      case Transitions.fade:
        return FadeTransition(opacity: animation, child: child);

      case Transitions.rotation:
        return RotationTransition(turns: animation, child: child);

      case Transitions.scale:
        return ScaleTransition(
          scale: animation.drive(Tween(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.ease))),
          child: child,
        );

      case Transitions.leftToRight:
        return _slideTransition(child, animation, const Offset(-1, 0));

      case Transitions.rightToLeft:
        return _slideTransition(child, animation, const Offset(1, 0));

      case Transitions.downToUp:
        return _slideTransition(child, animation, const Offset(0, 1));

      case Transitions.upToDown:
        return _slideTransition(child, animation, const Offset(0, -1));
    }
  }

  static SlideTransition _slideTransition(
    Widget child,
    Animation<double> animation,
    Offset begin,
  ) =>
      SlideTransition(
        position: Tween(
          begin: begin,
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      );
}
/* 
class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final Transitions transitions;

  CustomPageRoute(this.child, this.transitions)
      : super(
          transitionDuration: const Duration(seconds: 1),
          reverseTransitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      selectTransition(animation);

  Widget selectTransition(Animation<double> animation) {
    switch (transitions) {
      case Transitions.fade:
        return FadeTransition(opacity: animation, child: child);

      case Transitions.rotation:
        return RotationTransition(turns: animation, child: child);

      case Transitions.scale:
        return ScaleTransition(
          scale: animation.drive(Tween(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.ease))),
          child: child,
        );

      case Transitions.leftToRight:
        return _slideTransition(animation, const Offset(-1, 0));

      case Transitions.rightToLeft:
        return _slideTransition(animation, const Offset(1, 0));

      case Transitions.downToUp:
        return _slideTransition(animation, const Offset(0, 1));

      case Transitions.upToDown:
        return _slideTransition(animation, const Offset(0, -1));
    }
  }

  SlideTransition _slideTransition(Animation<double> animation, Offset begin) =>
      SlideTransition(
        position: Tween(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      );
}
 */
