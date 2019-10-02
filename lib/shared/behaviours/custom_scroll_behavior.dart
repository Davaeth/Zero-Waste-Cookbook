import 'package:flutter/material.dart';

ScrollConfiguration configureScrollBehavior(Widget child) =>
    ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: child,
    );

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
