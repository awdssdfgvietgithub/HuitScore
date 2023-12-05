import 'package:flutter/cupertino.dart';

extension NavigatorExtensionsClearBackstack on BuildContext {
  Future<T?> pushReplacementWithSlideTransitionClearBackstack<T>(
      Widget page, {
        Curve curve = Curves.ease,
      }) {
    return Navigator.of(this).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}

extension NavigatorExtensions on BuildContext {
  Future<T?> pushReplacementWithSlideTransition<T>(
      Widget page, {
        Curve curve = Curves.ease,
      }) {
    return Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}