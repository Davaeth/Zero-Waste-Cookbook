import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/pages/search/search_page.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

mixin NameSearch on State<Search> {
  Padding nameSearchWidget(BuildContext context) => addPadding(
        Container(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onSubmitted: (String text) => _searchForRecipeByName(text, context),
            cursorColor: DefaultColors.iconColor,
            style: TextStyle(color: DefaultColors.textColor, height: 0.8),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: DefaultColors.disabledIconColor),
              hintText: Translator.instance.translations['search_by_name'],
              prefixIcon: Icon(Icons.search, color: DefaultColors.iconColor),
              enabledBorder:
                  _buildOutlineInputBorder(DefaultColors.disabledIconColor),
              focusedBorder: _buildOutlineInputBorder(DefaultColors.iconColor),
            ),
          ),
        ),
      );

  Future<void> _searchForRecipeByName(String text, BuildContext context) async {
    var _dbService = DatabaseService();

    var recipesSnapshots = await _dbService.getDataByField(
      'Recipes',
      'recipeTitle',
      text.toLowerCase(),
    );

    if (recipesSnapshots.length == 1) {
      navigateToPageByRoute(Routes.Recipe, context,
          recipeId: recipesSnapshots.single.documentID);
    } else {
      var recipes = List<Recipe>();

      recipesSnapshots.forEach((snapshot) {
        recipes.add(Recipe.fromFirestore(snapshot));
      });

      navigateToPageByRoute(
        Routes.SearchingResultPage,
        context,
        recipes: recipes,
      );
    }
  }

  OutlineInputBorder _buildOutlineInputBorder(Color borderColor) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        borderSide: BorderSide(color: borderColor),
      );
}
