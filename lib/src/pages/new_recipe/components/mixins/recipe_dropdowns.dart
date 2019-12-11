import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/difficulty_level.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/region.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/dropdowns/difficulty_level_dropdown.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/dropdowns/dish_regions_dropdown.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/new_recipe_section.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/new_recipe.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

mixin RecipeDropdowns on State<NewRecipe> {
  NewRecipeSection buildDifficultyLevelDropdown(
          Function(DifficultyLevel) difficultyLevelDropdownCallback) =>
      NewRecipeSection(
        Translator.instance.translations['difficulty_level'],
        DifficultyLevelDropdown(
          callback: difficultyLevelDropdownCallback,
        ),
      );

  NewRecipeSection buildDishRegionsDropdown(
          Function(Region) dishRegionsDropdownCallback) =>
      NewRecipeSection(
        Translator.instance.translations['regions'],
        DishRegionsDropdown(
          callback: dishRegionsDropdownCallback,
        ),
      );
}
