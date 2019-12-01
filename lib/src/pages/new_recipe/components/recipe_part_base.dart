import 'package:flutter/material.dart';

import 'new_recipe_section.dart';

abstract class RecipePartBase<T> extends StatelessWidget {
  final Key newRecipeSectionKey;
  final Function(T) ingredientDialogCallback;
  final ListView ingredientsListView;

  RecipePartBase(
      {@required this.newRecipeSectionKey,
      @required this.ingredientDialogCallback,
      @required this.ingredientsListView});

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          createDataList(),
          createShowAddDataDialog(context),
        ],
      );

  NewRecipeSection createDataList();

  Padding createShowAddDataDialog(BuildContext context);
}
