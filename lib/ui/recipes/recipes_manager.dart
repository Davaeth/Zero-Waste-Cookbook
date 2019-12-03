import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card.dart';

class RecipesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipesManager();
}

class _RecipesManager extends State<RecipesManager> {
  DatabaseService _databaseService;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _databaseService.streamNewestRecipes(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) => ListView(
          padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: _createRecipeDetectors(snapshots),
        ),
      );

  @override
  void initState() {
    _databaseService = DatabaseService();
    super.initState();
  }

  List<RecipeCard> _createRecipeDetectors(
      AsyncSnapshot<QuerySnapshot> snapshots) {
    List<RecipeCard> gestures = List<RecipeCard>();

    var docs = snapshots?.data?.documents;

    for (var snapshot in docs) {
      gestures.add(
        RecipeCard(
          interior: RecipeCard.createInteriorForListOfCards(
              recipe: Recipe.fromFirestore(snapshot),
              imagePath: 'assets/images/small-food.png',
              userId: 'MtcBAWcygoW6ERK83agC'),
          recipeID: snapshot.documentID,
        ),
      );
    }

    return gestures;
  }
}
