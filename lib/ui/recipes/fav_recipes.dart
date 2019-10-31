import 'package:flutter/material.dart';
import 'package:template_name/shared/behaviours/custom_scroll_behavior.dart';
import 'package:template_name/shared/enums/page.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/page_resolvers/page_resolver.dart';
import 'package:template_name/shared/ui/cards/recipe_card.dart';
import 'package:template_name/shared/ui/recipes/recipes_manager.dart';

class FavRecipesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavRecipesManager();
}

class _FavRecipesManager extends State<FavRecipesManager> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) => RecipeCard(
            RecipeCard.createInteriorForListOfCards(
                'assets/images/small-food.png', 'Russian', '20min')),
      );
}
