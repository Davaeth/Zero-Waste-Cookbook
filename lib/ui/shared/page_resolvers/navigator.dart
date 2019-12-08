import 'package:flutter/material.dart';

void navigateToPageByRoute(String route, BuildContext context,
    {String recipeID}) {
  Navigator.pushNamed(context, route, arguments: recipeID);
}

void stepPageBack(BuildContext context) {
  Navigator.pop(context);
}

GestureDetector switchPage(BuildContext context, Widget child, String route,
        {String recipeID, bool isTappable = true}) =>
    GestureDetector(
      onTap: isTappable
          ? () {
              navigateToPageByRoute(route, context, recipeID: recipeID);
            }
          : () {},
      child: child,
    );
