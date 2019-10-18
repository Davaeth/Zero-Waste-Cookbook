import 'package:flutter/material.dart';

void navigateToPageByRoute(String route, BuildContext context) {
  Navigator.pushNamed(context, route);
}

void stepPageBack(BuildContext context) {
  Navigator.pop(context);
}

GestureDetector switchPage(BuildContext context, Widget child, String route) =>
    GestureDetector(
      onTap: () {
        navigateToPageByRoute(route, context);
      },
      child: child,
    );
