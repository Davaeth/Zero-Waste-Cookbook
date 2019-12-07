import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

import 'components/user_recipes_manager_item.dart';

class UserRecipesManager extends StatefulWidget {
  @override
  _UserRecipesManagerState createState() => _UserRecipesManagerState();
}

class _UserRecipesManagerState extends State<UserRecipesManager> {
  DatabaseService _databaseService;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close, color: DefaultColors.iconColor),
              alignment: Alignment.topRight,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconSize: 30.0,
              onPressed: () {
                stepPageBack(context);
              },
            ),
            FutureBuilder(
                future: _databaseService
                    .getUserRecipes('E5ewEF8YxDO0rl8Zue2zMrU7Yd43'),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  if (snapshots.hasData) {
                    var recipes = _getRecipesInfo(snapshots);

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: recipes.length,
                      itemBuilder: (context, index) => addPadding(
                        UserRecipesManagerItem(
                            recipe: recipes[index], callback: _managerCallback),
                        top: 16.0,
                      ),
                    );
                  } else {
                    return ListView();
                  }
                }),
          ],
        ),
      );

  void _managerCallback() {
    setState(() {});
  }

  @override
  void initState() {
    _databaseService = DatabaseService();

    super.initState();
  }

  List<Recipe> _getRecipesInfo(AsyncSnapshot<QuerySnapshot> snapshots) {
    List<Recipe> recipeInfo = List<Recipe>();

    for (var snapshot in snapshots.data.documents) {
      recipeInfo.add(Recipe.fromFirestore(snapshot));
    }

    return recipeInfo;
  }
}
