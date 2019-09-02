import 'package:flutter/material.dart';
import 'package:template_name/components/recipes/recipe_card.dart';

class RecipesMenager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipesMenager();
}

class _RecipesMenager extends State<RecipesMenager> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) => RecipeCard(
            RecipeCard.createInteriorForListOfeCards(
                'assets/images/small-food.png', 'Nowy przepis', 'Beleczka')),
      );
}
