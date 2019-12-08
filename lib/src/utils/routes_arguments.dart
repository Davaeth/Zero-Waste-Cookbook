import 'package:zero_waste_cookbook/src/models/food/recipe.dart';

class RoutesArguments {
  final String recipeId;
  final List<Recipe> recipes;

  RoutesArguments(this.recipeId, this.recipes);
}
