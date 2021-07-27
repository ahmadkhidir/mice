import 'package:flutter/material.dart';

class LeftSlideNavigator extends PageRouteBuilder {
  LeftSlideNavigator({required this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) {
              return widget;
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              Animation<Offset> slide = Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset(0, 0),
              ).animate(CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn));

              return SlideTransition(
                position: slide,
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
