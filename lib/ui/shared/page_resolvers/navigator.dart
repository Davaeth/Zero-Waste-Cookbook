import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/utils/routes_arguments.dart';

void navigateToPageByRoute(String route, BuildContext context,
    {String recipeId, List<Recipe> recipes}) {
  Navigator.pushNamed(context, route,
      arguments: RoutesArguments(recipeId, recipes));
}

void stepPageBack(BuildContext context) {
  Navigator.pop(context);
}

GestureDetector switchPage(BuildContext context, Widget child, String route,
        {String recipeId, List<Recipe> recipes, bool isTappable = true}) =>
    GestureDetector(
      onTap: isTappable
          ? () {
              navigateToPageByRoute(route, context,
                  recipeId: recipeId, recipes: recipes);
            }
          : () {},
      child: child,
    );
