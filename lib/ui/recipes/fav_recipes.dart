import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card.dart';

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
            interior: RecipeCard.createInteriorForListOfCards(
                'assets/images/small-food.png', 'Russian', '20min')),
      );
}
