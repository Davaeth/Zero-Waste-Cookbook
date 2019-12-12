import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/recipe_part_base.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

import 'add_recipe_dialog.dart';
import 'new_recipe_section.dart';

class RecipeIngredients extends RecipePartBase<Ingredient> {
  RecipeIngredients(
      Key newRecipeSectionKey,
      Function(Ingredient) ingredientDialogCallback,
      ListView ingredientsListView)
      : super(
            newRecipeSectionKey: newRecipeSectionKey,
            ingredientDialogCallback: ingredientDialogCallback,
            ingredientsListView: ingredientsListView);

  @override
  NewRecipeSection createDataList() => NewRecipeSection(
        Translator.instance.translations['ingredients'],
        ingredientsListView,
        key: newRecipeSectionKey,
      );

  @override
  Padding createShowAddDataDialog(BuildContext context) => addPadding(
        FlatButton(
          child: Text(Translator.instance.translations['add_an_ingredients']),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddRecipeDialog(ingredientDialogCallback),
            );
          },
          color: DefaultColors.iconColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        top: 16.0,
      );
}
