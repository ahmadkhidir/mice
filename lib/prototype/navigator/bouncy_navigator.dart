import 'package:flutter/material.dart';

class BouncyNavigator extends PageRouteBuilder {
  BouncyNavigator({required this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) {
              return widget;
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.bounceOut);
              return ScaleTransition(
                scale: animation,
                child: Container(
                  child: child,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      spreadRadius: 20,
                      blurRadius: 70,
                      color: Color(0x55000000),
                    )
                  ]),
                ),
              );
            });
  final Widget widget;
}
