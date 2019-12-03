import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card.dart';

class FavRecipesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavRecipesManager();
}

class _FavRecipesManager extends State<FavRecipesManager> {
  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _db.getUserFavouriteRecipes('MtcBAWcygoW6ERK83agC'),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshots) {
          var favRecipes = _extractFavRecipes(snapshots).toList();

          return ListView.builder(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) => RecipeCard(
              interior: RecipeCard.createInteriorForListOfCards(
                  recipe: favRecipes[index],
                  imagePath: 'assets/images/small-food.png',
                  userId: 'MtcBAWcygoW6ERK83agC'),
            ),
          );
        },
      );

  Iterable<Recipe> _extractFavRecipes(
      AsyncSnapshot<List<DocumentSnapshot>> snapshots) sync* {
    for (var snapshot in snapshots.data) {
      yield Recipe.fromFirestore(snapshot);
    }
  }
}
