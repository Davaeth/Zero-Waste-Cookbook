import 'package:flutter/material.dart';
import 'package:template_name/shared/enums/page.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';
import 'package:template_name/shared/ui/cards/recipe_card.dart';

class RecipesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipesMenager();
}

class _RecipesMenager extends State<RecipesManager> {
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
            Page.RecipePage),
      );
}
