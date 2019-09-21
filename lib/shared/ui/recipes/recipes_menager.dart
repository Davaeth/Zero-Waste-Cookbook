import 'package:flutter/material.dart';
import 'package:template_name/shared/ui/recipes/recipe_card.dart';

class RecipesMenager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipesMenager();
}

class _RecipesMenager extends State<RecipesMenager> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => RecipeCard(
            RecipeCard.createInteriorForListOfCards(
                'assets/images/small-food.png', 'Nowy przepis', 'Beleczka')),
      );
}
