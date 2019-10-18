import 'package:flutter/material.dart';
import 'package:template_name/ui/cards/recipe_card.dart';
import 'package:template_name/ui/constants/routes.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';

class RecipesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipesManager();
}

class _RecipesManager extends State<RecipesManager> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => switchPage(
            context,
            RecipeCard(RecipeCard.createInteriorForListOfCards(
                'assets/images/small-food.png', 'Nowy przepis', 'Beleczka')),
            Routes.Recipe),
      );
}
